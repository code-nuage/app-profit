import SignupTemplate from '../Templates/Signup.html';

import AccountIcon from '../Assets/account.svg';
import MailIcon from '../Assets/mail.svg';
import DateIcon from '../Assets/date.svg';
import LockIcon from '../Assets/lock.svg';

import '../Styles/signup.scss';

export default `${SignupTemplate}`
.replace('{{AccountIcon}}', AccountIcon)
.replace('{{MailIcon}}', MailIcon)
.replace('{{DateIcon}}', DateIcon)
.replaceAll('{{LockIcon}}', LockIcon);
