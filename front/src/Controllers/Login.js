import LoginModel from '../Models/Login.js'; 

import NavbarController from '../Controllers/Navbar.js';

import WhiteNoiseView from '../Views/WhiteNoise.js';
import LoginView from '../Views/Login.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.app.innerHTML = `<header id="navbar"></header>
<section id="login"></section>`
        this.login = document.querySelector('#login')
        this.run();
    }

    run() {
        new NavbarController();
        this.render();

        this.attachForm();
    }

    render() {
        this.login.innerHTML += `
            ${WhiteNoiseView}
            ${LoginView}
        `;
    }

    attachForm() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', async (event) => {
                event.preventDefault();

                LoginModel(this);
            });
        }
    }
}