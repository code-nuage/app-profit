import Config from '../config.js';

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
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })

        const result = await response.json();

        if (response.ok) {
            alert("Registered.");
        } else {
            alert("Error: " + result.error);
        }
    } catch(error) {
        alert('Can\'t connect to backend server: ' + error);
    }
}