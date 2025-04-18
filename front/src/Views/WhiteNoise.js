import WhiteNoiseTemplate from '../Templates/WhiteNoise.html';

import WhiteNoise from '../Assets/white-noise.png';

import '../Styles/white-noise.scss';

export default `${WhiteNoiseTemplate}`
.replace('{{WhiteNoise}}', WhiteNoise);
