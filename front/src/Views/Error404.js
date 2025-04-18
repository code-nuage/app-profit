import Error404Template from '../Templates/Error404.html';

import Icon from '../Assets/icon.png';

import '../Styles/error-404.scss';

export default `${Error404Template}`
.replace("{{Icon}}", Icon);
