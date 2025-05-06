import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarController from '../Controllers/Navbar.js';
import HomeView from '../Views/Home.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.app.innerHTML = `<header id="navbar"></header>
<section id="home"></section>`
        this.home = document.querySelector('#home');
        this.run();
    }

    run() {
        new NavbarController();
        this.render();
    }

    render() {
        this.home.innerHTML = `
            ${WhiteNoiseView}
            ${HomeView}
        `;
    }
}