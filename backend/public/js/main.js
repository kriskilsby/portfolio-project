console.log("Portfolio homepage loaded");

document.addEventListener("DOMContentLoaded", () => {
  // Remove no-js
  document.documentElement.classList.remove("no-js");

  const navbar = document.querySelector(".navbar");
  const navbarSlot = document.querySelector(".navbar-d1-slot");
  const hamburger = document.querySelector('.navbar-toggler'); // select the hamburger button
  const heroD1 = document.querySelector(".hero-d1");
  const heroD2 = document.querySelector(".hero-d2");
  const heroD3 = document.querySelector(".hero-d3");
  const aboutIntro = document.querySelector(".about-intro");
  const aboutTitle = document.querySelector(".about-title");
  const aboutText = document.querySelector(".about-text");

  if (!heroD1 || !heroD2 || !heroD3 || !aboutIntro) {
    console.warn("Hero or About elements not found!");
    return;
  }

  // Show hero D1 immediately
  heroD1.classList.add("visible");

  // Ensure D2/D3 start hidden
  heroD2.classList.remove("show");
  heroD3.classList.remove("show");

  // Run scroll logic once on load
  // window.dispatchEvent(new Event("scroll"));

 

  // Scroll-based animations
  // window.addEventListener("scroll", () => {
  //   const scrollY = window.scrollY;
  //   const progress = Math.min(scrollY / triggerDistance, 1);

  //   // 1) While NOT past trigger: visually animate hero d1
  //   if (scrollY < triggerDistance) {
  //     // Ensure D1 is in the hero area (restore if it isn't)
  //     if (heroD1.parentNode !== originalParent) {
  //       // insert before the original next sibling (handles null correctly)
  //       originalParent.insertBefore(heroD1, originalNextSibling);
  //       heroD1.classList.remove("shrink");
  //     }

  //     // Apply smooth transform based on progress
  //     const translateY = -progress * 60;           // pixels upward while scrolling
  //     const scale = 1 - progress * 0.35;           // final scale when reaching trigger
  //     heroD1.style.transform = `translateY(${translateY}px) scale(${scale})`;
  //     heroD1.style.opacity = (1 - progress * 0.08).toString();
  //   } else {
  //     // 2) Once past trigger: move into navbar (real move)
  //     if (heroD1.parentNode !== navbarSlot) {
  //       // clear inline transform first if you want visual snap to match
  //       heroD1.style.transform = "";
  //       heroD1.style.opacity = "";
  //       navbarSlot.appendChild(heroD1);   // 👈 use slot, not brand
  //       heroD1.classList.add("shrink");
  //     }
  //   }

  //   // Navbar background only after hero is passed
  //   if (scrollY > window.innerHeight - 100) {
  //     navbar.classList.add("scrolled");
  //   } else {
  //     navbar.classList.remove("scrolled");
  //   }

  //   // Show D2 & D3 together
  //   if (scrollY > 50) {
  //     heroD2.classList.add("show");
  //     heroD3.classList.add("show");
  //   } else {
  //     heroD2.classList.remove("show");
  //     heroD3.classList.remove("show");
  //   }
  // });

  // kk changed from below to add d1 text to navbar 

  // ###############################################################################
  // const navbarBrand = navbar.querySelector(".navbar-brand");
  // const originalParent = heroD1.parentNode;   
  // const originalNextSibling = heroD1.nextSibling; 

  // // const triggerDistance =300;
  // const triggerDistance = window.innerHeight * 0.80; // 60% of viewport height 

  // // const heroStartRect = heroD1.getBoundingClientRect();
  
  // // Scroll-based animations
  // window.addEventListener("scroll", () => {
  //   const scrollY = window.scrollY;
  //   const progress = Math.min(scrollY / triggerDistance, 1);

  //   // Optional: easing
  //   // const easedProgress = 1 - Math.pow(1 - progress, 2);

  //   // Easing for smoother shrink 
  //   const easedProgress = Math.pow(progress, 1.5);

  //   const heroRect = heroD1.getBoundingClientRect();
  //   const navbarRect = navbarSlot.getBoundingClientRect();
  //   const travelY = heroRect.top - navbarRect.top;

  //   const heroFontSize = parseFloat(getComputedStyle(heroD1).fontSize);
  //   const navbarFontSize = parseFloat(getComputedStyle(navbarSlot).fontSize);
  //   // const minScale = Math.min(navbarFontSize / heroFontSize, 0.25);
  //   const minScale = navbarFontSize / heroFontSize;

  //   // 1) While NOT past trigger: visually animate hero D1
  //   if (scrollY < triggerDistance) {
  //     // Ensure heroD1 is in hero area
  //     if (heroD1.parentNode !== originalParent) {
  //       originalParent.insertBefore(heroD1, originalNextSibling);
  //       heroD1.classList.remove("shrink");
  //     }

  //     // const maxTranslate = 50;    // vh
  //     // const translateY = -progress * maxTranslate;

  //     // Smooth transform and opacity
  //     // const translateY = -progress * 50;
  //     // heroD1.style.transform = `translateY(${translateY}vh) scale(${1 - progress * 0.90})`;
  //     // const minScale = 0.25;               // final navbar size
  //     // const scale = 1 - progress * (1 - minScale);


  //     const translateY = -easedProgress * travelY;
  //     const scale = 1 - easedProgress * (1 - minScale);

  //     // heroD1.style.transform = `translateY(${translateY}vh) scale(${scale})`;
  //     // heroD1.style.opacity = (1 - progress * 0.05).toString();

  //     heroD1.style.transform = `translateY(${translateY}px) scale(${scale})`;
  //     heroD1.style.opacity = (1 - easedProgress * 0.45).toString();

  //     // Navbar D1 hidden while hero D1 visible
  //   //   navbarSlot.classList.remove("visible");
  //   // } else {
  //     // Hero D1 has “finished” moving — fade out

  //     // Fade in navbar slot starting around 60% progress
  //     const fadeInStart = triggerDistance * 0.5; 
  //     const fadeProgress = Math.min( 
  //       Math.max((scrollY - fadeInStart) / (triggerDistance - fadeInStart), 0), 
  //       1 
  //     ); 
  //     navbarSlot.style.opacity = fadeProgress; 
  //   } else {
  //     heroD1.style.transform = "";
  //     heroD1.style.opacity = "0";
  //     heroD1.classList.add("shrink");

  //     navbarSlot.style.opacity = 1; 
  //   }
  //     // Show permanent D1 in navbar
    

  //   // Navbar background only after hero is passed
  //   if (scrollY > window.innerHeight - 100) {
  //     navbar.classList.add("scrolled");
  //   } else {
  //     navbar.classList.remove("scrolled");
  //   }

  //   // Show D2 & D3 together
  //   if (scrollY > 50) {
  //     heroD2.classList.add("show");
  //     heroD3.classList.add("show");
  //   } else {
  //     heroD2.classList.remove("show");
  //     heroD3.classList.remove("show");
  //   }
  // });
  // ###############################################################################

  window.addEventListener("load", () => {
    const heroRect = heroD1.getBoundingClientRect();
    const navbarRect = navbarSlot.getBoundingClientRect();
    const travelY = heroRect.top - navbarRect.top;

    const heroFontSize = parseFloat(getComputedStyle(heroD1).fontSize);
    const navbarFontSize = parseFloat(getComputedStyle(navbarSlot).fontSize);
    const minScale = navbarFontSize / heroFontSize;

    console.log(`DEBUG: heroFontSize = ${heroFontSize} navbarFontSize = ${navbarFontSize} minScale = ${minScale}`);

    // --- tweakable constants ---
    const TRIGGER_DISTANCE = (travelY + heroRect.height) * 0.6; // scroll distance
    const EASE_POWER = 1.2; // higher = slower easing
    const HERO_OPACITY_FADE = 1; // max fade out of hero D1
    const NAV_FADE_START = 0.80; // progress at which navbar D1 starts fading in
    const NAV_FADE_END = 0.9;   // progress at which navbar D1 is fully visible

    window.addEventListener("scroll", () => {
      const scrollY = window.scrollY;
      let progress = Math.min((scrollY / TRIGGER_DISTANCE) * 1.2, 1); // tweak multiplier for speed
      const easedProgress = Math.pow(progress, EASE_POWER);

      // Hero transform
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

      // Navbar D1 fade
      let navProgress = Math.min(Math.max((progress - NAV_FADE_START) / (NAV_FADE_END - NAV_FADE_START), 0), 1);
      navbarSlot.style.opacity = navProgress;

      console.log(`DEBUG: scrollY = ${scrollY.toFixed(1)} progress = ${progress.toFixed(2)} translateY = ${translateY.toFixed(1)} scale = ${scale.toFixed(3)} opacity = ${opacity.toFixed(2)} navOpacity = ${navProgress.toFixed(2)}`);

      // Navbar background
      if (scrollY > window.innerHeight - 100) {
        navbar.classList.add("scrolled");
      } else {
        navbar.classList.remove("scrolled");
      }

      // Show D2 & D3
      if (scrollY > 75) {
        heroD2.classList.add("show");
        heroD3.classList.add("show");
      } else {
        heroD2.classList.remove("show");
        heroD3.classList.remove("show");
      }
    });

    // Run once at load
    window.dispatchEvent(new Event("scroll"));
  });




 


  // About intro observer
  const titleObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      entry.target.classList.toggle("visible", entry.isIntersecting);
    });
  }, { threshold: 0.8 });

  titleObserver.observe(aboutTitle);

  // Text observer
  const textObserver = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      entry.target.classList.toggle("visible", entry.isIntersecting);
    });
  }, { threshold: 0.6 });

  textObserver.observe(aboutText);

  // const cards = document.querySelectorAll(".card"); 

  // const cardObserver = new IntersectionObserver((entries) => { 
  //   entries.forEach(entry => { 
  //     // toggle .visible depending on whether card is in viewport
  //     entry.target.classList.toggle("visible", entry.isIntersecting);
  //   });
  // }, { threshold: 0.5, rootMargin: "0px 0px -10% 0px" }); // triggers when 25% of card is visible

  // cards.forEach((card, index) => {
  //   cardObserver.observe(card);
  //   card.style.transitionDelay = `${index * 0.2}s`; // staggered entrance
  // });


  hamburger.addEventListener('click', () => {
    navbar.classList.toggle('open');
  });


});


