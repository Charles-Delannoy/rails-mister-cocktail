import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Find cocktails", "Make cocktails", "Share your recipes"],
    typeSpeed: 70,
    loop: true
  });
}

export { loadDynamicBannerText };
