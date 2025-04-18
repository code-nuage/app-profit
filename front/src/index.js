import Router from './router.js';

import HomeController from './Controllers/Home.js';
import AboutController from './Controllers/About.js';
import LoginController from './Controllers/Login.js';
import SignupController from './Controllers/Signup.js';

import './Styles/profit-design-system.css';

const routes = [{
    url: '/',
    controller: HomeController
},
{
    url: '/about',
    controller: AboutController
},
{
    url: '/login',
    controller: LoginController
},
{
    url: '/signup',
    controller: SignupController
}];

new Router(routes);