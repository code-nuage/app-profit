import LoginTemplate from '../Templates/Login.html';

import MailIcon from '../Assets/mail.svg';
import LockIcon from '../Assets/lock.svg';

import '../Styles/login.scss';

export default `${LoginTemplate}`
.replace('{{MailIcon}}', MailIcon)
.replace('{{LockIcon}}', LockIcon);
