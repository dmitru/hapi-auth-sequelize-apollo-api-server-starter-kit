import createServer from 'app/server';

createServer().then(server => {
  server.start(err => {
    if (err) {
      throw err;
    }
    console.log('Server running at:', server.info.uri);
  });
});
