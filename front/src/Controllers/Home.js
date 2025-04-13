import NavbarView from '../Views/Navbar.js';
import HomeView from '../Views/Home.js';

import WhiteNoise from '../Assets/white-noise.png';
import Capote from '../Assets/capote.svg';

import '../Styles/home.css';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
    }

    render() {
        this.app.innerHTML = `
            <img src='${WhiteNoise}' class="white-noise">
            ${NavbarView}
            ${HomeView}
        `;
        document.querySelector('.capote').src = Capote;
    }
}