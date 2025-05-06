import SignupModel from '../Models/Signup.js';

import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarController from '../Controllers/Navbar.js';
import SignupView from '../Views/Signup.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.app.innerHTML = `<header id="navbar"></header>
<section id="signup"></section>`
        this.signup = document.querySelector('#signup');
        this.run();
    }

    run() {
        new NavbarController();
        this.render();
        document.querySelector('form').addEventListener('submit', async function(event) {
            event.preventDefault();
            
            SignupModel();
        })
    }

    render() {
        this.signup.innerHTML = `
            ${WhiteNoiseView}
            ${SignupView}
        `;
    }
}
