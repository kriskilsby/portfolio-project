console.log("Portfolio homepage loaded");

document.addEventListener("DOMContentLoaded", () => {
  // Remove no-js
  document.documentElement.classList.remove("no-js");

  const navbar = document.querySelector(".navbar");
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
  window.dispatchEvent(new Event("scroll"));

  // Scroll-based animations
  window.addEventListener("scroll", () => {
    const scrollY = window.scrollY;

    // Shrink hero D1 once user scrolls past 50px
    if(scrollY > 50) {
      heroD1.classList.add("shrink");
    } else {
      heroD1.classList.remove("shrink");
    }

    // Only add navbar background once hero is passed
    if (window.scrollY > window.innerHeight - 100) {
      navbar.classList.add("scrolled");
    }else {
      navbar.classList.remove("scrolled");
    }

    // Removed below code to shrink D1 into navbar
    // if (window.scrollY > 50) heroD1.classList.add("shrink");
    // else heroD1.classList.remove("shrink");
    // Removed below code to shrink D1 into navbar

    
    // Removed below code to stop the navbar chanign colour too early
    // Shrink hero once user scrolls past 50px
    // if(scrollY > 50) {
    //   heroD1.classList.add("shrink");
    //   navbar.classList.add("scrolled"); // keeps navbar styling consistent
    // } else {
    //   heroD1.classList.remove("shrink");
    //   navbar.classList.remove("scrolled");
    // }
    // Removed above code to stop the navbar chanign colour too early


    // Added back below code to make d2 & d3 not independent
    if (window.scrollY > 50) {
      heroD2.classList.add("show");
      heroD3.classList.add("show");
    } else {
      heroD2.classList.remove("show");
      heroD3.classList.remove("show");
    }
    // added back above code to make d2 & d3 not independent
    // if (window.scrollY > 50) {
    //   heroD2.classList.add("show");
    // } else {
    //   heroD2.classList.remove("show");
    // }

    // if (window.scrollY > 50) {
    //   heroD3.classList.add("show");
    // } else {
    //   heroD3.classList.remove("show");
    // }

  });

  // About section reveal
  // const observer = new IntersectionObserver(entries => {
  //   entries.forEach(entry => {
  //     if (entry.isIntersecting) entry.target.classList.add("visible");
  //     else entry.target.classList.remove("visible");
  //   });
  // }, { threshold: 0.75 });

  // observer.observe(aboutIntro);
  // About section reveal (separate title + text)
   // Single observer for about section
  // Title observer
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

  const cards = document.querySelectorAll(".card"); 

  const cardObserver = new IntersectionObserver((entries) => { 
    entries.forEach(entry => { 
      // toggle .visible depending on whether card is in viewport
      entry.target.classList.toggle("visible", entry.isIntersecting);
    });
  }, { threshold: 0.5, rootMargin: "0px 0px -10% 0px" }); // triggers when 25% of card is visible

  cards.forEach((card, index) => {
    cardObserver.observe(card);
    card.style.transitionDelay = `${index * 0.2}s`; // staggered entrance
  });

});
