import NavbarTemplate from '../Templates/Navbar.html';

import AccountIcon from '../Assets/account.svg';

import '../Styles/navbar.scss';

let View = `${NavbarTemplate}`
.replace("{{UserName}}", "")
.replace("{{AccountIcon}}", AccountIcon);

export default View;
