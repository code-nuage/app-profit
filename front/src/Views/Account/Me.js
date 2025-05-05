import MeTemplate from '../../Templates/Account/Me.html';

import '../../Styles/account/me.scss';

export default (datas) => {
    console.log(datas);
    let View = `${MeTemplate}`
    .replace("{{Username}}", datas.name)

    return View;
};
