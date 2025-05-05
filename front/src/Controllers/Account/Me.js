import WhiteNoiseView from '../../Views/WhiteNoise.js';
import NavbarView from '../../Views/Navbar.js';
import AccountMeView from '../../Views/Account/Me.js';

import UserModel from '../../Models/User.js';
import LogoutModel from '../../Models/Logout.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    async run() {
        this.dataUser = await UserModel();

        this.render();

        document.querySelector('#logout').addEventListener('click', async function(event) {
            event.preventDefault();
            
            LogoutModel();
        })
    }

    async render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${AccountMeView(this.dataUser)}
        `;
    }
}