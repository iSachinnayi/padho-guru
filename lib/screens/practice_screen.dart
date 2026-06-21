import 'dart:async';
import 'package:flutter/material.dart';
import '../config/theme.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  String _selectedSubject = 'Science';
  int? _selectedAnswer;
  int _currentQuestion = 0;
  int _score = 0;
  bool _showResult = false;
  bool _quizStarted = false;

  Timer? _timer;
  int _secondsRemaining = 300; // 5 minutes

  final _subjects = ['Science', 'Maths', 'Hindi', 'English'];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'प्रकाश का परावर्तन किस सतह पर होता है?',
      'options': [
        'खुरदरी सतह',
        'चिकनी व चमकदार सतह',
        'काली सतह',
        'पारदर्शी सतह',
      ],
      'correct': 1,
    },
    {
      'question': 'प्रकाश संश्लेषण के लिए क्या आवश्यक है?',
      'options': [
        'ऑक्सीजन',
        'सूर्य का प्रकाश',
        'कार्बन डाइऑक्साइड',
        'सूर्य का प्रकाश और कार्बन डाइऑक्साइड',
      ],
      'correct': 3,
    },
    {
      'question': 'न्यूटन के गति के प्रथम नियम को किस नाम से जाना जाता है?',
      'options': [
        'जड़त्व का नियम',
        'त्वरण का नियम',
        'क्रिया-प्रतिक्रिया का नियम',
        'ऊर्जा संरक्षण का नियम',
      ],
      'correct': 0,
    },
    {
      'question': 'कोशिका की खोज किसने की?',
      'options': ['रॉबर्ट हुक', 'नील्स बोहर', 'आइंस्टीन', 'न्यूटन'],
      'correct': 0,
    },
    {
      'question': 'पाइथागोरस प्रमेय किससे संबंधित है?',
      'options': [
        'वृत्त',
        'समकोण त्रिभुज',
        'समांतर चतुर्भुज',
        'आयत',
      ],
      'correct': 1,
    },
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startQuiz() {
    setState(() {
      _quizStarted = true;
      _currentQuestion = 0;
      _score = 0;
      _showResult = false;
      _selectedAnswer = null;
      _secondsRemaining = 300;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        _finishQuiz();
        return;
      }
      setState(() => _secondsRemaining--);
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) return;

    if (_selectedAnswer == _questions[_currentQuestion]['correct']) {
      _score++;
    }

    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    _timer?.cancel();
    setState(() => _showResult = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('प्रैक्टिस'),
        actions: [
          if (_quizStarted && !_showResult)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!_quizStarted) return _buildStartScreen();
    if (_showResult) return _buildResultScreen();
    return _buildQuizScreen();
  }

  Widget _buildStartScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.quiz_outlined,
                  color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            const Text(
              'प्रैक्टिस टेस्ट',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'NCERT पर आधारित 5 सवाल',
              style: TextStyle(
                  fontSize: 14, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
            // Subject selector
            SizedBox(
              width: 200,
              child: DropdownButtonFormField(
                initialValue: _selectedSubject,
                items: _subjects
                    .map((s) => DropdownMenuItem(
                        value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _selectedSubject = v!),
                decoration: const InputDecoration(
                  labelText: 'विषय चुनें',
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _startQuiz,
                icon: const Icon(Icons.play_arrow),
                label: const Text('शुरू करें'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    final q = _questions[_currentQuestion];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_currentQuestion + 1) / _questions.length,
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_currentQuestion + 1}/${_questions.length}',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Question
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.cardShadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              q['question'],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          // Options
          ...List.generate(
            q['options'].length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _selectedAnswer = i),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _selectedAnswer == i
                        ? AppTheme.primary.withValues(alpha: 0.1)
                        : AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedAnswer == i
                          ? AppTheme.primary
                          : AppTheme.divider,
                      width: _selectedAnswer == i ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedAnswer == i
                              ? AppTheme.primary
                              : AppTheme.background,
                          border: Border.all(
                            color: _selectedAnswer == i
                                ? AppTheme.primary
                                : AppTheme.divider,
                          ),
                        ),
                        child: Center(
                          child: _selectedAnswer == i
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 14)
                              : Text(
                                  String.fromCharCode(
                                      65 + i), // A, B, C, D
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        q['options'][i],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Submit
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _selectedAnswer != null
                  ? _submitAnswer
                  : null,
              child: Text(
                _currentQuestion < _questions.length - 1
                    ? 'अगला सवाल'
                    : 'समाप्त करें',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    final percent = _score / _questions.length;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              percent >= 0.8
                  ? '🏆'
                  : percent >= 0.5
                      ? '👍'
                      : '💪',
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 16),
            Text(
              '$_score/${_questions.length}',
              style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              percent >= 0.8
                  ? 'बहुत शानदार! 🎉'
                  : percent >= 0.5
                      ? 'अच्छा है, और सुधार करो!'
                      : 'कोई बात नहीं, फिर से प्रयास करो!',
              style: const TextStyle(
                  fontSize: 16, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _startQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('फिर से शुरू करें'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => setState(() {
                  _quizStarted = false;
                  _showResult = false;
                }),
                child: const Text('होम जाएं'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
