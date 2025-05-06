import User from '../Models/User.js';
import UserModel from '../Models/User.js';

import NavbarView from '../Views/Navbar.js';

export default class NavbarController {
    constructor() {
        this.navbar = document.querySelector('#navbar');
        this.run();
    }

    run() {
        this.render();
        
        this.accountButton = document.querySelector('.account');

        document.querySelector('.account').addEventListener('click', (e) => {
            console.log(UserModel());
            if (UserModel() == false) {
                window.location.replace(window.location.origin + '/login');
            } else {
                window.location.replace(window.location.origin + '/account');
            }
        })
    }

    render() {
        this.navbar.innerHTML += `
            ${NavbarView}
        `;
    }
}