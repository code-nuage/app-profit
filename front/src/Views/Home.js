import HomeTemplate from '../Templates/Home.html';

import Icon from '../Assets/icon.png';

import '../Styles/home.scss';

export default `${HomeTemplate}`
.replace("{{Icon}}", Icon);
