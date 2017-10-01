// @flow
/* eslint-disable no-unused-vars */

import { merge, map, union, without, castArray } from 'lodash';

const combine = (features, extractor): any =>
  without(union(...map(features, res => castArray(extractor(res)))), undefined);

type FeatureParams = {
  typeDefs: String | String[],
  createResolversFunc: Function | Function[],
  createContextFunc?: Function | Function[],
};

class Feature {
  typeDefs: String[];
  createResolversFunc: Function[];
  createContextFunc: Function[];

  constructor(feature?: FeatureParams, ...features: Feature[]) {
    this.typeDefs = combine(arguments, arg => arg.typeDefs);
    this.createResolversFunc = combine(arguments, arg => arg.createResolversFunc);
    this.createContextFunc = combine(arguments, arg => arg.createContextFunc);
  }

  async createContext(req: any, connectionParams: any, webSocket: any) {
    const results = await Promise.all(this.createContextFunc.map(createContext => createContext(req, connectionParams, webSocket)));
    return merge({}, ...results);
  }

  createResolvers(pubsub: any) {
    return merge({}, ...this.createResolversFunc.map(createResolvers => createResolvers(pubsub)));
  }
}

export default Feature;

export function combineFeatures(...features: Feature[]) {
  return new Feature(...features);
}
