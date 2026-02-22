/**
 * BETNA - Premium Homepage JavaScript
 * i18n, Mobile Menu, Scroll Animations, Counter
 */

// ========================================
// 1. TRANSLATIONS
// ========================================
const translations = {
    en: {
        nav_contact: "Contact Us",
        nav_about: "About Us",
        nav_properties: "Properties",
        nav_stats: "Track Record",
        hero_badge: "LUXURY REAL ESTATE",
        hero_title: "Where Architecture<br>Meets <em>Legacy</em>",
        hero_subtitle: "Curating Istanbul's finest properties for visionary investors.",
        hero_btn: "Explore Properties",
        hero_btn2: "Learn More",
        about_label: "WHY BETNA",
        about_title: "Built on Trust.<br>Driven by Excellence.",
        about_desc: "Betna is Istanbul's most trusted real estate partner, offering end-to-end services for discerning buyers and investors. From premium residences to strategic commercial assets, we deliver unmatched expertise with complete transparency.",
        feat1_title: "Legal Security",
        feat1_desc: "Full legal vetting and title verification on every property.",
        feat2_title: "Market Intelligence",
        feat2_desc: "Data-driven insights ensuring maximum return on investment.",
        feat3_title: "White-Glove Service",
        feat3_desc: "Personalized concierge from first inquiry to key handover.",
        stat1_label: "Premium Units",
        stat2_label: "Client Satisfaction",
        stat3_label: "Years Experience",
        stat4_label: "Portfolio Value (USD)",
        prop_label: "FEATURED",
        prop_title: "Signature Collection",
        badge_luxury: "ULTRA-LUXURY",
        badge_sig: "SIGNATURE",
        badge_mod: "MODERN",
        prop_view_all: "View Full Collection →",
        cta_title: "Ready to Invest<br>in Istanbul?",
        cta_desc: "Get a free consultation from our expert advisors today.",
        cta_btn: "Chat on WhatsApp",
        footer_desc: "Istanbul's trusted partner for premium real estate investments.",
        footer_social: "Social",
        footer_legal: "Legal",
        footer_copy: "© 2026 Betna. All rights reserved."
    },
    tr: {
        nav_contact: "İletişim",
        nav_about: "Hakkımızda",
        nav_properties: "Portföy",
        nav_stats: "Başarılarımız",
        hero_badge: "LÜKS GAYRİMENKUL",
        hero_title: "Mimarlık <em>Mirası</em><br>ile Buluşuyor",
        hero_subtitle: "Vizyoner yatırımcılar için İstanbul'un en seçkin mülklerini küratörlüyoruz.",
        hero_btn: "Portföyü İncele",
        hero_btn2: "Daha Fazla Bilgi",
        about_label: "NEDEN BETNA",
        about_title: "Güvene Dayalı.<br>Mükemmellik Odaklı.",
        about_desc: "Betna, seçici alıcılar ve yatırımcılar için uçtan uca hizmet sunan İstanbul'un en güvenilir gayrimenkul ortağıdır. Premium konutlardan stratejik ticari varlıklara kadar, tam şeffaflıkla eşsiz uzmanlık sunuyoruz.",
        feat1_title: "Hukuki Güvence",
        feat1_desc: "Her mülkte tam hukuki inceleme ve tapu doğrulaması.",
        feat2_title: "Pazar Zekası",
        feat2_desc: "Maksimum yatırım getirisi sağlayan veriye dayalı içgörüler.",
        feat3_title: "VIP Hizmet",
        feat3_desc: "İlk sorgudan anahtar teslimine kişiselleştirilmiş danışmanlık.",
        stat1_label: "Premium Ünite",
        stat2_label: "Müşteri Memnuniyeti",
        stat3_label: "Yıllık Deneyim",
        stat4_label: "Portföy Değeri (USD)",
        prop_label: "ÖNE ÇIKAN",
        prop_title: "İmza Koleksiyonu",
        badge_luxury: "ULTRA-LÜKS",
        badge_sig: "İMZA",
        badge_mod: "MODERN",
        prop_view_all: "Tüm Koleksiyonu Gör →",
        cta_title: "İstanbul'a Yatırım<br>Yapmaya Hazır mısınız?",
        cta_desc: "Uzman danışmanlarımızdan bugün ücretsiz danışmanlık alın.",
        cta_btn: "WhatsApp ile Yazın",
        footer_desc: "Premium gayrimenkul yatırımlarında İstanbul'un güvenilir ortağı.",
        footer_social: "Sosyal",
        footer_legal: "Hukuki",
        footer_copy: "© 2026 Betna. Tüm hakları saklıdır."
    },
    ar: {
        nav_contact: "تواصل معنا",
        nav_about: "من نحن",
        nav_properties: "العقارات",
        nav_stats: "سجلّنا",
        hero_badge: "عقارات فاخرة",
        hero_title: "حيث تلتقي العمارة<br>بـ<em>الإرث</em>",
        hero_subtitle: "ننتقي أرقى عقارات إسطنبول للمستثمرين أصحاب الرؤية.",
        hero_btn: "استكشف العقارات",
        hero_btn2: "اعرف المزيد",
        about_label: "لماذا بتنى",
        about_title: "مبنية على الثقة.<br>مدفوعة بالتميّز.",
        about_desc: "بتنى هو الشريك العقاري الأكثر ثقة في إسطنبول، يقدم خدمات شاملة للمشترين والمستثمرين المميزين. من المساكن الفاخرة إلى الأصول التجارية الاستراتيجية، نقدم خبرة لا مثيل لها بشفافية تامة.",
        feat1_title: "أمان قانوني",
        feat1_desc: "تدقيق قانوني كامل والتحقق من سند الملكية لكل عقار.",
        feat2_title: "ذكاء السوق",
        feat2_desc: "رؤى مبنية على البيانات تضمن أقصى عائد على الاستثمار.",
        feat3_title: "خدمة راقية",
        feat3_desc: "استشارات شخصية من أول استفسار حتى تسليم المفتاح.",
        stat1_label: "وحدة فاخرة",
        stat2_label: "رضا العملاء",
        stat3_label: "سنوات خبرة",
        stat4_label: "قيمة المحفظة (دولار)",
        prop_label: "مميّزة",
        prop_title: "المجموعة المختارة",
        badge_luxury: "فخامة فائقة",
        badge_sig: "توقيعنا",
        badge_mod: "حديث",
        prop_view_all: "عرض المجموعة الكاملة ←",
        cta_title: "مستعدّ للاستثمار<br>في إسطنبول؟",
        cta_desc: "احصل على استشارة مجانية من خبرائنا اليوم.",
        cta_btn: "تحدث عبر واتساب",
        footer_desc: "شريككم الموثوق للاستثمارات العقارية الفاخرة في إسطنبول.",
        footer_social: "التواصل",
        footer_legal: "قانوني",
        footer_copy: "© 2026 بتنى. جميع الحقوق محفوظة."
    }
};

// ========================================
// 2. LANGUAGE ENGINE
// ========================================
let currentLang = localStorage.getItem('betna_lang') || null;

function setLanguage(lang) {
    currentLang = lang;
    localStorage.setItem('betna_lang', lang);
    
    // Set HTML attributes
    document.documentElement.lang = lang;
    document.documentElement.dir = lang === 'ar' ? 'rtl' : 'ltr';

    // Update all translated elements
    const dict = translations[lang];
    document.querySelectorAll('[data-i18n]').forEach(el => {
        const key = el.getAttribute('data-i18n');
        if (dict[key]) {
            el.innerHTML = dict[key];
        }
    });

    // Update active state on language buttons
    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.lang === lang);
    });
}

function detectLanguage() {
    if (currentLang && translations[currentLang]) {
        setLanguage(currentLang);
        return;
    }
    const browserLang = (navigator.language || navigator.userLanguage || 'en').split('-')[0];
    setLanguage(translations[browserLang] ? browserLang : 'en');
}

// ========================================
// 3. MOBILE MENU
// ========================================
function setupMobileMenu() {
    const burger = document.getElementById('burger');
    const menu = document.getElementById('mobile-menu');
    if (!burger || !menu) return;

    burger.addEventListener('click', () => {
        burger.classList.toggle('open');
        menu.classList.toggle('open');
    });

    // Close menu when a link is clicked
    menu.querySelectorAll('.mobile-link').forEach(link => {
        link.addEventListener('click', () => {
            burger.classList.remove('open');
            menu.classList.remove('open');
        });
    });
}

// ========================================
// 4. NAVBAR SCROLL
// ========================================
function setupNavbar() {
    const navbar = document.getElementById('navbar');
    let lastScroll = 0;
    
    window.addEventListener('scroll', () => {
        const scrollY = window.scrollY;
        navbar.classList.toggle('scrolled', scrollY > 60);
        lastScroll = scrollY;
    }, { passive: true });
}

// ========================================
// 5. SCROLL REVEAL
// ========================================
function setupReveal() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.15, rootMargin: '0px 0px -40px 0px' });

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
}

// ========================================
// 6. ANIMATED COUNTER
// ========================================
function setupCounters() {
    const counters = document.querySelectorAll('.stat-number[data-count]');
    let counted = false;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !counted) {
                counted = true;
                counters.forEach(counter => {
                    const target = parseInt(counter.dataset.count, 10);
                    const duration = 2000;
                    const start = performance.now();

                    function update(now) {
                        const elapsed = now - start;
                        const progress = Math.min(elapsed / duration, 1);
                        const eased = 1 - Math.pow(1 - progress, 3); // ease-out cubic
                        counter.textContent = Math.floor(eased * target);
                        if (progress < 1) {
                            requestAnimationFrame(update);
                        } else {
                            counter.textContent = target;
                        }
                    }
                    requestAnimationFrame(update);
                });
            }
        });
    }, { threshold: 0.3 });

    const statsSection = document.getElementById('stats');
    if (statsSection) observer.observe(statsSection);
}

// ========================================
// 7. PRELOADER
// ========================================
function setupPreloader() {
    const preloader = document.getElementById('preloader');
    if (!preloader) return;
    
    window.addEventListener('load', () => {
        setTimeout(() => {
            preloader.classList.add('hidden');
        }, 2000);
    });
}

// ========================================
// 8. BOOT
// ========================================
document.addEventListener('DOMContentLoaded', () => {
    detectLanguage();
    setupMobileMenu();
    setupNavbar();
    setupReveal();
    setupCounters();
    setupPreloader();

    // Language button click handlers
    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            setLanguage(btn.dataset.lang);
        });
    });
});
