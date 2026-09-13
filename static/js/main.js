/* ==================================================================
   Achraf Hasnaoui — Portfolio interactions.
   All content is rendered server-side by Hugo from data/portfolio.yaml;
   this file only wires up animations and UI behavior.
   ================================================================== */

function onReady(fn) {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', fn);
  } else {
    fn();
  }
}

/* ---------- Hero typewriter ---------- */
onReady(function () {
  var el = document.getElementById('typewriter');
  if (!el) return;

  var phrases = ['software engineer.'];
  var rolesEl = document.getElementById('hero-roles');
  if (rolesEl) {
    try {
      var parsed = JSON.parse(rolesEl.textContent);
      if (Array.isArray(parsed) && parsed.length) phrases = parsed;
    } catch (err) { /* fall back to default */ }
  }

  var TYPE_SPEED = 55;
  var ERASE_SPEED = 28;
  var HOLD_MS = 1700;

  var phraseIndex = 0;
  var charIndex = 0;
  var deleting = false;

  function tick() {
    var current = phrases[phraseIndex] || '';
    charIndex = deleting ? charIndex - 1 : charIndex + 1;
    el.textContent = current.slice(0, charIndex);

    var delay;
    if (!deleting && charIndex === current.length) {
      deleting = true;
      delay = HOLD_MS;
    } else if (deleting && charIndex === 0) {
      deleting = false;
      phraseIndex = (phraseIndex + 1) % phrases.length;
      delay = 350;
    } else {
      delay = deleting ? ERASE_SPEED : TYPE_SPEED;
    }
    setTimeout(tick, delay);
  }

  setTimeout(tick, 400);
});

/* ---------- Marquee: duplicate the group for a seamless loop ---------- */
onReady(function () {
  var track = document.getElementById('marqueeTrack');
  if (!track) return;
  track.innerHTML += track.innerHTML;
});

/* ---------- Navbar: add shadow on scroll ---------- */
(function () {
  var navbar = document.getElementById('navbar');
  if (!navbar) return;
  window.addEventListener('scroll', function () {
    navbar.classList.toggle('scrolled', window.scrollY > 10);
  });
})();

/* ---------- Mobile nav toggle ---------- */
(function () {
  var toggle = document.getElementById('navToggle');
  var links = document.getElementById('navLinks');
  if (!toggle || !links) return;

  toggle.addEventListener('click', function () {
    var open = links.classList.toggle('open');
    toggle.classList.toggle('open', open);
    toggle.setAttribute('aria-expanded', String(open));
  });

  links.querySelectorAll('a').forEach(function (a) {
    a.addEventListener('click', function () {
      links.classList.remove('open');
      toggle.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
    });
  });
})();

/* ---------- Scroll reveal ---------- */
onReady(function () {
  var revealEls = document.querySelectorAll('.reveal');
  if (!('IntersectionObserver' in window)) {
    revealEls.forEach(function (el) { el.classList.add('visible'); });
    return;
  }
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.15, rootMargin: '0px 0px -40px 0px' });
  revealEls.forEach(function (el) { observer.observe(el); });
});

/* ---------- Skill bars animation ---------- */
onReady(function () {
  var fills = document.querySelectorAll('.skill-fill');
  if (!fills.length) return;
  var animate = function (el) {
    var width = el.getAttribute('data-width') || '0';
    el.style.width = width + '%';
  };
  if (!('IntersectionObserver' in window)) {
    fills.forEach(animate);
    return;
  }
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        animate(entry.target);
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.4 });
  fills.forEach(function (el) { observer.observe(el); });
});

/* ---------- Scrollspy: highlight active nav link ---------- */
onReady(function () {
  var sections = document.querySelectorAll('section[id]');
  var navLinks = document.querySelectorAll('.nav-link');
  if (!sections.length || !navLinks.length) return;

  var spy = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (!entry.isIntersecting) return;
      var id = entry.target.getAttribute('id');
      navLinks.forEach(function (link) {
        link.classList.toggle('active', link.getAttribute('href') === '#' + id);
      });
    });
  }, { rootMargin: '-40% 0px -55% 0px' });
  sections.forEach(function (section) { spy.observe(section); });
});
