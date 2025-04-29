import Config from '../config.js';

import NotificationController from '../Controllers/Notification.js';

export default async function() {
    const name = document.querySelector('#name').value;
    const email = document.querySelector('#email').value;
    const birthdate = document.querySelector('#birthdate').value;
    const password = document.querySelector('#password').value;
    const passwordConfirm = document.querySelector('#password-confirm').value;

    if (password !== passwordConfirm) {
        alert("Les mots de passe doivent correspondre!");
        return;
    };

    const data = {
        name,
        email,
        birthdate,
        password,
        role: "USER"
    };

    try {
        const response = await fetch(Config.BACKEND_URL + ':' + Config.BACKEND_PORT + "/register", {
            method: 'POST',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })

        const result = await response.json();
        console.log(response.headers);
        console.log(response.status);
        console.log(result);

        if (response.status == 200) {
            new NotificationController("Inscription", "Utilisateur créé.", "primary");
        } else {
            new NotificationController("Inscription", result.error, "negative");
        }
    } catch(error) {
        alert('Can\'t connect to backend server: ' + error);
    }
}