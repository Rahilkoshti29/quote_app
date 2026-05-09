class Quote {
  final int id;
  final String text;
  final String author;
  final String category;
  bool isFavorite;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    this.isFavorite = false,
  });
}

// ── Quote Database ─────────────────────────────────────────────────────────────
final List<Quote> allQuotes = [
  // Motivation
  Quote(id: 1, text: "The only way to do great work is to love what you do.", author: "Steve Jobs", category: "Motivation"),
  Quote(id: 2, text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius", category: "Motivation"),
  Quote(id: 3, text: "Everything you've ever wanted is on the other side of fear.", author: "George Addair", category: "Motivation"),
  Quote(id: 4, text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill", category: "Motivation"),
  Quote(id: 5, text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt", category: "Motivation"),
  Quote(id: 6, text: "Your time is limited, so don't waste it living someone else's life.", author: "Steve Jobs", category: "Motivation"),
  Quote(id: 7, text: "The harder the conflict, the greater the triumph.", author: "George Washington", category: "Motivation"),
  Quote(id: 8, text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson", category: "Motivation"),

  // Wisdom
  Quote(id: 9, text: "The unexamined life is not worth living.", author: "Socrates", category: "Wisdom"),
  Quote(id: 10, text: "Knowing yourself is the beginning of all wisdom.", author: "Aristotle", category: "Wisdom"),
  Quote(id: 11, text: "The only true wisdom is in knowing you know nothing.", author: "Socrates", category: "Wisdom"),
  Quote(id: 12, text: "In the middle of difficulty lies opportunity.", author: "Albert Einstein", category: "Wisdom"),
  Quote(id: 13, text: "Yesterday I was clever, so I wanted to change the world. Today I am wise, so I am changing myself.", author: "Rumi", category: "Wisdom"),
  Quote(id: 14, text: "The measure of intelligence is the ability to change.", author: "Albert Einstein", category: "Wisdom"),
  Quote(id: 15, text: "By three methods we may learn wisdom: reflection, which is noblest; imitation, which is easiest; and experience, which is bitterest.", author: "Confucius", category: "Wisdom"),

  // Success
  Quote(id: 16, text: "Success usually comes to those who are too busy to be looking for it.", author: "Henry David Thoreau", category: "Success"),
  Quote(id: 17, text: "The secret of success is to do the common thing uncommonly well.", author: "John D. Rockefeller", category: "Success"),
  Quote(id: 18, text: "I find that the harder I work, the more luck I seem to have.", author: "Thomas Jefferson", category: "Success"),
  Quote(id: 19, text: "Success is walking from failure to failure with no loss of enthusiasm.", author: "Winston Churchill", category: "Success"),
  Quote(id: 20, text: "The road to success and the road to failure are almost exactly the same.", author: "Colin R. Davis", category: "Success"),
  Quote(id: 21, text: "Opportunities don't happen. You create them.", author: "Chris Grosser", category: "Success"),

  // Life
  Quote(id: 22, text: "Life is what happens to us while we are making other plans.", author: "Allen Saunders", category: "Life"),
  Quote(id: 23, text: "In the end, it's not the years in your life that count. It's the life in your years.", author: "Abraham Lincoln", category: "Life"),
  Quote(id: 24, text: "Life is either a daring adventure or nothing at all.", author: "Helen Keller", category: "Life"),
  Quote(id: 25, text: "To live is the rarest thing in the world. Most people exist, that is all.", author: "Oscar Wilde", category: "Life"),
  Quote(id: 26, text: "Life is not measured by the number of breaths we take, but by the moments that take our breath away.", author: "Maya Angelou", category: "Life"),
  Quote(id: 27, text: "You only live once, but if you do it right, once is enough.", author: "Mae West", category: "Life"),

  // Courage
  Quote(id: 28, text: "Courage is not the absence of fear, but the triumph over it.", author: "Nelson Mandela", category: "Courage"),
  Quote(id: 29, text: "It takes courage to grow up and become who you really are.", author: "E.E. Cummings", category: "Courage"),
  Quote(id: 30, text: "You gain strength, courage, and confidence by every experience in which you really stop to look fear in the face.", author: "Eleanor Roosevelt", category: "Courage"),
  Quote(id: 31, text: "Courage is grace under pressure.", author: "Ernest Hemingway", category: "Courage"),

  // Happiness
  Quote(id: 32, text: "Happiness is not something ready made. It comes from your own actions.", author: "Dalai Lama", category: "Happiness"),
  Quote(id: 33, text: "For every minute you are angry you lose sixty seconds of happiness.", author: "Ralph Waldo Emerson", category: "Happiness"),
  Quote(id: 34, text: "The most important thing is to enjoy your life — to be happy. It's all that matters.", author: "Audrey Hepburn", category: "Happiness"),
  Quote(id: 35, text: "Happiness is when what you think, what you say, and what you do are in harmony.", author: "Mahatma Gandhi", category: "Happiness"),
  Quote(id: 36, text: "Count your age by friends, not years. Count your life by smiles, not tears.", author: "John Lennon", category: "Happiness"),

  // Mindset
  Quote(id: 37, text: "Whether you think you can or you think you can't, you're right.", author: "Henry Ford", category: "Mindset"),
  Quote(id: 38, text: "The mind is everything. What you think you become.", author: "Buddha", category: "Mindset"),
  Quote(id: 39, text: "Change your thoughts and you change your world.", author: "Norman Vincent Peale", category: "Mindset"),
  Quote(id: 40, text: "Once you replace negative thoughts with positive ones, you'll start having positive results.", author: "Willie Nelson", category: "Mindset"),
  Quote(id: 41, text: "A man is but the product of his thoughts. What he thinks, he becomes.", author: "Mahatma Gandhi", category: "Mindset"),

  // Creativity
  Quote(id: 42, text: "Creativity is intelligence having fun.", author: "Albert Einstein", category: "Creativity"),
  Quote(id: 43, text: "You can't use up creativity. The more you use, the more you have.", author: "Maya Angelou", category: "Creativity"),
  Quote(id: 44, text: "Imagination is more important than knowledge.", author: "Albert Einstein", category: "Creativity"),
  Quote(id: 45, text: "Every artist was first an amateur.", author: "Ralph Waldo Emerson", category: "Creativity"),

  // Perseverance
  Quote(id: 46, text: "Fall seven times, stand up eight.", author: "Japanese Proverb", category: "Perseverance"),
  Quote(id: 47, text: "Our greatest glory is not in never failing, but in rising every time we fail.", author: "Confucius", category: "Perseverance"),
  Quote(id: 48, text: "Energy and persistence conquer all things.", author: "Benjamin Franklin", category: "Perseverance"),
  Quote(id: 49, text: "It always seems impossible until it's done.", author: "Nelson Mandela", category: "Perseverance"),
  Quote(id: 50, text: "The gem cannot be polished without friction, nor man perfected without trials.", author: "Chinese Proverb", category: "Perseverance"),
];

final List<String> categories = [
  'All', 'Motivation', 'Wisdom', 'Success', 'Life',
  'Courage', 'Happiness', 'Mindset', 'Creativity', 'Perseverance'
];

final Map<String, String> categoryEmojis = {
  'All': '✨',
  'Motivation': '🔥',
  'Wisdom': '🦉',
  'Success': '🏆',
  'Life': '🌿',
  'Courage': '⚡',
  'Happiness': '☀️',
  'Mindset': '🧠',
  'Creativity': '🎨',
  'Perseverance': '💪',
};

// Global favorites state (in-memory for simplicity; use SharedPreferences for persistence)
final Set<int> favoriteIds = {};