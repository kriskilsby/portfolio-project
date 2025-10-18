
console.log("Portfolio script loaded");

document.addEventListener("DOMContentLoaded", () => {
  // Remove no-js class if present
  document.documentElement.classList.remove("no-js");

  const navbar = document.querySelector(".navbar");
  const isIndexPage = document.body.classList.contains("index");

  // --- Navbar background fix ---
  if (isIndexPage) {
    const updateNavbarBackground = () => {
      if (window.scrollY > window.innerHeight - 100) {
        navbar.classList.add("scrolled");
      } else {
        navbar.classList.remove("scrolled");
      }
    };

    updateNavbarBackground();
    window.addEventListener("scroll", updateNavbarBackground);
  } else {
    navbar.classList.add("scrolled");
  }
  // --- End Navbar fix ---

  const navbarSlot = document.querySelector(".navbar-d1-slot");
  const hamburger = document.querySelector(".navbar-toggler");

  // Detect if this is the homepage
  // const isIndexPage = document.body.classList.contains("index");

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

  // === Profile script animation ===
  // Select the elements you want to animate
  // const revealElements = document.querySelectorAll(
  //   '.profile-title, .profile-text, .accordion-button'
  // );

  // // Add the 'reveal' class to all selected elements
  // revealElements.forEach(el => el.classList.add('reveal'));

  // // Set up the Intersection Observer
  // const observerOptions = {
  //   threshold: 0.1, // trigger when 20% of element is visible
  // };

  // const observer = new IntersectionObserver((entries, observer) => {
  //   entries.forEach(entry => {
  //     if (entry.isIntersecting) {
  //       entry.target.classList.add('visible'); // triggers CSS animation
  //       observer.unobserve(entry.target);       // animate once only
  //     }
  //   });
  // }, observerOptions);

  // // Observe each element
  // revealElements.forEach(el => observer.observe(el));

  // Elements
  const textElements = document.querySelectorAll('.profile-title, .profile-text');
  const buttonElements = document.querySelectorAll('.accordion-button');

  // Add initial classes
  textElements.forEach(el => el.classList.add('reveal-text'));
  buttonElements.forEach(el => el.classList.add('reveal-button'));

  // ===== Observer for text (fade & slide) =====
  const textObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  // Optional: stagger the text reveal
  textElements.forEach((el, i) => {
    el.style.transitionDelay = `${i * 1.6}s`; // stagger 0.3s per element
    textObserver.observe(el);
  });

// ===== Observer for buttons (jiggle) =====
  const buttonObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      } else {
        entry.target.classList.remove('visible'); // optional fade out when leaving
      }
    });
  }, { threshold: 0.1 });

 // Immediately reveal any buttons already in view on load
  buttonElements.forEach(el => {
    const rect = el.getBoundingClientRect();
    const inView = rect.top >= 0 && rect.bottom <= window.innerHeight;
    if (inView) {
      el.classList.add("visible");
    } else {
      buttonObserver.observe(el);
    }
  });
  
  // Move accordion button date and re-order layout on smaller screens 
  function handleAccordionLayout() {
    const isMobile = window.matchMedia("(max-width: 991px)").matches;

    document.querySelectorAll('.accordion-item').forEach(item => {
      const button = item.querySelector('.accordion-button');
      let dateSpan = button.querySelector('.date');

      const body = item.querySelector('.accordion-body');
      const picture = body.querySelector('picture.accordion-img');
      const text = body.querySelector('.accordion-text');

      // ===== Handle date movement/removal =====
      if (isMobile) {
        if (dateSpan) {
          button.dataset.dateText = dateSpan.textContent.trim();
          dateSpan.remove();
        }

        // Move picture above text on smaller screens
        if (picture && text && picture.nextElementSibling !== text) {
          body.insertBefore(picture, text);
        }

      } else {
        // Restore date if missing
        if (!dateSpan && button.dataset.dateText) {
          const newSpan = document.createElement('span');
          newSpan.className = 'date text-white text-end ms-3';
          newSpan.textContent = button.dataset.dateText;
          button.appendChild(newSpan);
          delete button.dataset.dateText;
        }

        // Move picture back to the right on desktop
        if (picture && text && picture.previousElementSibling === text) {
          body.insertBefore(text, picture);
        }
      }
    });
  }

  // Run on load and resize
  window.addEventListener('DOMContentLoaded', handleAccordionLayout);
  window.addEventListener('resize', handleAccordionLayout);

  document.getElementById("year").textContent = new Date().getFullYear();

});


