import UserModel from '../../Models/User.js';
import LogoutModel from '../../Models/Logout.js';

import WhiteNoiseView from '../../Views/WhiteNoise.js';
import AccountMeView from '../../Views/Account/Me.js';

import NavbarController from '../../Controllers/Navbar.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.app.innerHTML = `<header id="navbar"></header>
<section id="me"></section>`;
        this.me = document.querySelector('#me');
        this.run();
    }

    async run() {
        this.dataUser = await UserModel();

        this.render();
        new NavbarController();

        document.querySelector('#logout').addEventListener('click', async function(event) {
            event.preventDefault();
            
            LogoutModel();
        })
    }

    async render() {
        this.me.innerHTML = `
            ${WhiteNoiseView}
            ${AccountMeView(this.dataUser)}
        `;
    }
}