import NotificationTemplate from '../Templates/Notification.html';

import CloseIcon from '../Assets/close.svg';
import NotificationIcon from '../Assets/notification.svg';

import '../Styles/notification.scss';

let View = `${NotificationTemplate}`
.replace("{{CloseIcon}}", CloseIcon)
.replace("{{NotificationIcon}}", NotificationIcon);

export default View;