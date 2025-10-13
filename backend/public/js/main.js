// console.log("Portfolio homepage loaded");

// #######################################################
// document.addEventListener("DOMContentLoaded", () => {
//   // Remove no-js
//   document.documentElement.classList.remove("no-js");

//   const navbar = document.querySelector(".navbar");
//   const isIndexPage = document.body.classList.contains('index');
//   const navbarSlot = document.querySelector(".navbar-d1-slot");
//   const hamburger = document.querySelector('.navbar-toggler'); // select the hamburger button
//   const heroD1 = document.querySelector(".hero-d1");
//   const heroD2 = document.querySelector(".hero-d2");
//   const heroD3 = document.querySelector(".hero-d3");
//   const aboutIntro = document.querySelector(".about-intro");
//   const aboutTitle = document.querySelector(".about-title");
//   const aboutText = document.querySelector(".about-text");

//   if (!heroD1 || !heroD2 || !heroD3 || !aboutIntro) {
//     console.warn("Hero or About elements not found!");
//     return;
//   }

//   // Show hero D1 immediately
//   heroD1.classList.add("visible");

//   // Ensure D2/D3 start hidden
//   heroD2.classList.remove("show");
//   heroD3.classList.remove("show");

  

//   window.addEventListener("load", () => {
//     const heroRect = heroD1.getBoundingClientRect();
//     const navbarRect = navbarSlot.getBoundingClientRect();
//     const travelY = heroRect.top - navbarRect.top;

//     const heroFontSize = parseFloat(getComputedStyle(heroD1).fontSize);
//     const navbarFontSize = parseFloat(getComputedStyle(navbarSlot).fontSize);
//     const minScale = navbarFontSize / heroFontSize;

//     console.log(`DEBUG: heroFontSize = ${heroFontSize} navbarFontSize = ${navbarFontSize} minScale = ${minScale}`);

//     // --- tweakable constants ---
//     const TRIGGER_DISTANCE = Math.max((travelY + heroRect.height) * 0.6, 1);
//     const EASE_POWER = 1.2;
//     const HERO_OPACITY_FADE = 1;
//     const NAV_FADE_START = 0.80;
//     const NAV_FADE_END = 0.90;

//     // Scroll handler
//     const handleScroll = () => {
//       const scrollY = window.scrollY;
//       let progress = Math.min((scrollY / TRIGGER_DISTANCE) * 1.2, 1);
//       const easedProgress = Math.pow(progress, EASE_POWER);

//       // Hero transform
//       let scale = 1 - (1 - minScale) * easedProgress;
//       let translateY = -travelY * easedProgress;
//       let opacity = 1 - HERO_OPACITY_FADE * easedProgress;

//       if (progress >= 1) {
//         scale = minScale;
//         translateY = -travelY;
//         opacity = 0;
//       }

//       heroD1.style.transform = `translateY(${translateY}px) scale(${scale})`;
//       heroD1.style.opacity = opacity;

//       // Navbar D1 fade
//       const navProgress = Math.min(
//         Math.max((progress - NAV_FADE_START) / (NAV_FADE_END - NAV_FADE_START), 0),
//         1
//       );
//       navbarSlot.style.opacity = navProgress;

//       // Navbar background
//       if (scrollY > window.innerHeight - 100) navbar.classList.add("scrolled");
//       else navbar.classList.remove("scrolled");

//       // Hero D2/D3 reveal
//       if (scrollY > 75) {
//         heroD2.classList.add("show");
//         heroD3.classList.add("show");
//       } else {
//         heroD2.classList.remove("show");
//         heroD3.classList.remove("show");
//       }

//       console.log(
//         `DEBUG: scrollY=${scrollY.toFixed(1)} progress=${progress.toFixed(2)} translateY=${translateY.toFixed(1)} scale=${scale.toFixed(3)} opacity=${opacity.toFixed(2)} nav=${navProgress.toFixed(2)}`
//       );
//     };

//     // Determine initial state based on scroll position
//     const initialScrollY = window.scrollY;
//     if (initialScrollY + window.innerHeight / 2 >= heroRect.bottom) {
//       // Past hero: show navbar D1 immediately
//       navbarSlot.style.opacity = 1;
//       heroD1.style.opacity = 0;
//       heroD1.style.transform = `translateY(0px) scale(1)`; // stay at top, not from bottom
//     } else {
//       // Hero visible
//       navbarSlot.style.opacity = 0;
//       heroD1.style.opacity = 1;
//       heroD1.style.transform = `translateY(0px) scale(1)`;
//     }

//     // Attach scroll handler
//     window.addEventListener("scroll", handleScroll);

//     // Run once immediately
//     handleScroll();

//     // Run shortly after load (some browsers finalize scroll later)
//     setTimeout(handleScroll, 80);

//     // Handle pageshow (bfcache / back-forward restore)
//     window.addEventListener("pageshow", () => {
//       handleScroll();
//       setTimeout(handleScroll, 80);
//     });
//   });


//   // About intro observer
//   const titleObserver = new IntersectionObserver(entries => {
//     entries.forEach(entry => {
//       entry.target.classList.toggle("visible", entry.isIntersecting);
//     });
//   }, { threshold: 0.8 });

//   titleObserver.observe(aboutTitle);

//   // Text observer
//   const textObserver = new IntersectionObserver(entries => {
//     entries.forEach(entry => {
//       entry.target.classList.toggle("visible", entry.isIntersecting);
//     });
//   }, { threshold: 0.6 });

//   textObserver.observe(aboutText);

//   // ### REMOVE FOR NOW BUT MAY BRING BACK LATER ###
//   // const cards = document.querySelectorAll(".card"); 

//   // const cardObserver = new IntersectionObserver((entries) => { 
//   //   entries.forEach(entry => { 
//   //     // toggle .visible depending on whether card is in viewport
//   //     entry.target.classList.toggle("visible", entry.isIntersecting);
//   //   });
//   // }, { threshold: 0.5, rootMargin: "0px 0px -10% 0px" }); // triggers when 25% of card is visible

//   // cards.forEach((card, index) => {
//   //   cardObserver.observe(card);
//   //   card.style.transitionDelay = `${index * 0.2}s`; // staggered entrance
//   // });
//   // ### REMOVE FOR NOW BUT MAY BRING BACK LATER ###

//   hamburger.addEventListener('click', () => {
//     navbar.classList.toggle('open');
//   });

// });
// #######################################################


console.log("Portfolio script loaded");

document.addEventListener("DOMContentLoaded", () => {
  // Remove no-js class if present
  document.documentElement.classList.remove("no-js");

  const navbar = document.querySelector(".navbar");
  const navbarSlot = document.querySelector(".navbar-d1-slot");
  const hamburger = document.querySelector(".navbar-toggler");

  // Detect if this is the homepage
  const isIndexPage = document.body.classList.contains("index");

  // Hero elements (only exist on index)
  const heroD1 = document.querySelector(".hero-d1");
  const heroD2 = document.querySelector(".hero-d2");
  const heroD3 = document.querySelector(".hero-d3");
  const aboutIntro = document.querySelector(".about-intro");
  const aboutTitle = document.querySelector(".about-title");
  const aboutText = document.querySelector(".about-text");

  // === Navbar background behaviour ===
  if (isIndexPage) {
    // Dynamic scroll-based background
    window.addEventListener("scroll", () => {
      if (window.scrollY > window.innerHeight - 100) {
        navbar.classList.add("scrolled");
      } else {
        navbar.classList.remove("scrolled");
      }
    });
  } else {
    // Always show background on non-index pages
    navbar.classList.add("scrolled");
  }

  // === HERO + ABOUT ANIMATION (only for index page) ===
  if (isIndexPage && heroD1 && heroD2 && heroD3 && aboutIntro) {
    heroD1.classList.add("visible");
    heroD2.classList.remove("show");
    heroD3.classList.remove("show");

    window.addEventListener("load", () => {
      const heroRect = heroD1.getBoundingClientRect();
      const navbarRect = navbarSlot.getBoundingClientRect();
      const travelY = heroRect.top - navbarRect.top;

      const heroFontSize = parseFloat(getComputedStyle(heroD1).fontSize);
      const navbarFontSize = parseFloat(getComputedStyle(navbarSlot).fontSize);
      const minScale = navbarFontSize / heroFontSize;

      const TRIGGER_DISTANCE = Math.max((travelY + heroRect.height) * 0.6, 1);
      const EASE_POWER = 1.2;
      const HERO_OPACITY_FADE = 1;
      const NAV_FADE_START = 0.8;
      const NAV_FADE_END = 0.9;

      const handleScroll = () => {
        const scrollY = window.scrollY;
        let progress = Math.min((scrollY / TRIGGER_DISTANCE) * 1.2, 1);
        const easedProgress = Math.pow(progress, EASE_POWER);

        let scale = 1 - (1 - minScale) * easedProgress;
        let translateY = -travelY * easedProgress;
        let opacity = 1 - HERO_OPACITY_FADE * easedProgress;

        if (progress >= 1) {
          scale = minScale;
          translateY = -travelY;
          opacity = 0;
        }

        heroD1.style.transform = `translateY(${translateY}px) scale(${scale})`;
        heroD1.style.opacity = opacity;

        const navProgress = Math.min(
          Math.max((progress - NAV_FADE_START) / (NAV_FADE_END - NAV_FADE_START), 0),
          1
        );
        navbarSlot.style.opacity = navProgress;

        // Hero D2/D3 reveal
        if (scrollY > 75) {
          heroD2.classList.add("show");
          heroD3.classList.add("show");
        } else {
          heroD2.classList.remove("show");
          heroD3.classList.remove("show");
        }
      };

      // Set initial state
      const initialScrollY = window.scrollY;
      if (initialScrollY + window.innerHeight / 2 >= heroRect.bottom) {
        navbarSlot.style.opacity = 1;
        heroD1.style.opacity = 0;
      } else {
        navbarSlot.style.opacity = 0;
        heroD1.style.opacity = 1;
      }

      window.addEventListener("scroll", handleScroll);
      handleScroll();
      setTimeout(handleScroll, 80);

      window.addEventListener("pageshow", () => {
        handleScroll();
        setTimeout(handleScroll, 80);
      });
    });

    // === About section animation ===
    const titleObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          entry.target.classList.toggle("visible", entry.isIntersecting);
        });
      },
      { threshold: 0.8 }
    );
    titleObserver.observe(aboutTitle);

    const textObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          entry.target.classList.toggle("visible", entry.isIntersecting);
        });
      },
      { threshold: 0.6 }
    );
    textObserver.observe(aboutText);
  }

  // === Navbar hamburger toggle ===
  if (hamburger) {
    hamburger.addEventListener("click", () => {
      navbar.classList.toggle("open");
    });
  }
});


