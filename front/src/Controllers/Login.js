import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import LoginView from '../Views/Login.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${LoginView}
        `;
    }
}