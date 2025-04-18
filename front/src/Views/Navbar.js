import NavbarTemplate from '../Templates/Navbar.html';

import AccountIcon from '../Assets/account.svg';

import '../Styles/navbar.scss';

export default `${NavbarTemplate}`
.replace("{{AccountIcon}}", AccountIcon);