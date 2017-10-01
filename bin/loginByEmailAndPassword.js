import { createSessionTokenAndLogin } from 'app/features/users/auth';
import models from 'app/models';

(async () => {
  try {
    const email = process.argv[2];
    const user = await models.User.findOne({ where: { email } });
    if (!user) {
      console.error('User not found:', email);
      process.exit(1);
      return;
    }
    const token = await createSessionTokenAndLogin(user);
    console.log(token);
    process.exit(0);
  } catch (err) {
    console.error(err);
    process.exit(2);
  }
})();
