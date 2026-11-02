/* =============================================================================
   Achraf Hasnaoui — Portfolio Interactions
   Vanilla JS, zero dependencies, lightning fast & accessible.
   ============================================================================= */

function onReady(fn) {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', fn);
  } else {
    fn();
  }
}

/* ---------- 1. Hero Typewriter Effect ---------- */
onReady(function () {
  var el = document.getElementById('typewriter');
  if (!el) return;

  var phrases = [
    'Élève-Ingénieur en Génie Informatique (ENSIT).',
    'Développeur Full Stack & Backend.',
    'Praticien Cybersécurité & Membre Securinets.',
    'Passionné Cloud, DevOps & CI/CD.',
    'Concepteur IA, MLOps & Audio DSP.',
    'Maker Systèmes Embarqués & IoT.'
  ];

  var rolesEl = document.getElementById('hero-roles');
  if (rolesEl) {
    try {
      var parsed = JSON.parse(rolesEl.textContent);
      if (Array.isArray(parsed) && parsed.length) phrases = parsed;
    } catch (err) { /* use default */ }
  }

  var TYPE_SPEED = 48;
  var ERASE_SPEED = 24;
  var HOLD_MS = 2100;

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
      delay = 320;
    } else {
      delay = deleting ? ERASE_SPEED : TYPE_SPEED;
    }
    setTimeout(tick, delay);
  }

  setTimeout(tick, 450);
});

/* ---------- 2. Seamless Marquee Loop ---------- */
onReady(function () {
  var track = document.getElementById('marqueeTrack');
  if (!track) return;
  track.innerHTML += track.innerHTML;
});

/* ---------- 3. Interactive Projects Filter ---------- */
onReady(function () {
  var filterBtns = document.querySelectorAll('.filter-btn');
  var projectCards = document.querySelectorAll('#projectsGrid .project-card');

  if (!filterBtns.length || !projectCards.length) return;

  filterBtns.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var filter = this.getAttribute('data-filter');

      // Update active button state
      filterBtns.forEach(function (b) { b.classList.remove('active'); });
      this.classList.add('active');

      // Filter cards with smooth fade
      projectCards.forEach(function (card) {
        var cardCat = card.getAttribute('data-category');
        if (filter === 'all' || cardCat === filter) {
          card.classList.remove('hidden');
          // re-trigger reveal transition
          card.style.opacity = '0';
          card.style.transform = 'translateY(15px)';
          setTimeout(function () {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
          }, 40);
        } else {
          card.classList.add('hidden');
        }
      });
    });
  });
});

/* ---------- 4. Copy Email to Clipboard with Tooltip Feedback ---------- */
onReady(function () {
  var btn = document.getElementById('copyEmailBtn');
  if (!btn) return;

  var label = btn.querySelector('.btn-copy-label');
  var defaultText = label ? label.textContent : 'Copy email';
  var copiedText = btn.getAttribute('data-copied') || 'Email copied! ✓';
  var email = btn.getAttribute('data-email') || 'achrafhas2003@gmail.com';
  var timeoutId = null;

  btn.addEventListener('click', function () {
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(email).then(function () {
        showCopied();
      }).catch(function () {
        fallbackCopy();
      });
    } else {
      fallbackCopy();
    }
  });

  function showCopied() {
    if (label) label.textContent = copiedText;
    btn.style.borderColor = 'var(--emerald)';
    btn.style.color = 'var(--emerald)';

    clearTimeout(timeoutId);
    timeoutId = setTimeout(function () {
      if (label) label.textContent = defaultText;
      btn.style.borderColor = '';
      btn.style.color = '';
    }, 2400);
  }

  function fallbackCopy() {
    var input = document.createElement('input');
    input.value = email;
    document.body.appendChild(input);
    input.select();
    try {
      document.execCommand('copy');
      showCopied();
    } catch (e) { /* ignore */ }
    document.body.removeChild(input);
  }
});

/* ---------- 5. Navbar Scrolled Shadow ---------- */
(function () {
  var navbar = document.getElementById('navbar');
  if (!navbar) return;
  var onScroll = function () {
    navbar.classList.toggle('scrolled', window.scrollY > 15);
  };
  window.addEventListener('scroll', onScroll, { passive: true });
})();

/* ---------- 6. Mobile Nav Drawer Toggle ---------- */
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

  // Close on Escape key
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && links.classList.contains('open')) {
      links.classList.remove('open');
      toggle.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
    }
  });
})();

/* ---------- 7. Scroll Reveal Animation ---------- */
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
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  revealEls.forEach(function (el) { observer.observe(el); });
});

/* ---------- 8. Skill Progress Bars Animation ---------- */
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
  }, { threshold: 0.3 });

  fills.forEach(function (el) { observer.observe(el); });
});

/* ---------- 9. Scrollspy for Active Nav Link ---------- */
onReady(function () {
  var sections = document.querySelectorAll('section[id]');
  var navLinks = document.querySelectorAll('.nav-link');
  if (!sections.length || !navLinks.length) return;

  var spy = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (!entry.isIntersecting) return;
      var id = entry.target.getAttribute('id');
      navLinks.forEach(function (link) {
        var href = link.getAttribute('href') || '';
        link.classList.toggle('active', href.endsWith('#' + id));
      });
    });
  }, { rootMargin: '-35% 0px -55% 0px' });

  sections.forEach(function (section) { spy.observe(section); });
});
