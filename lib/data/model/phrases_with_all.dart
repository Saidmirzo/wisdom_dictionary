import 'package:wisdom/data/model/word_model.dart';
import 'package:wisdom/data/model/words_uz_model.dart';
import 'package:wisdom/data/model/collocation_model.dart';
import 'package:wisdom/data/model/culture_model.dart';
import 'package:wisdom/data/model/difference_model.dart';
import 'package:wisdom/data/model/grammar_model.dart';
import 'package:wisdom/data/model/metaphor_model.dart';
import 'package:wisdom/data/model/parent_phrases_example_model.dart';
import 'package:wisdom/data/model/parent_phrases_model.dart';
import 'package:wisdom/data/model/parents_model.dart';
import 'package:wisdom/data/model/phrases_example_model.dart';
import 'package:wisdom/data/model/phrases_model.dart';
import 'package:wisdom/data/model/phrases_translate_model.dart';
import 'package:wisdom/data/model/parent_phrases_translate_model.dart';
import 'package:wisdom/data/model/thesaurus_model.dart';

class PhrasesWithAll {
  PhrasesModel? phrases;
  List<PhrasesTranslateModel>? phrasesTranslate;
  List<PhrasesExampleModel>? phrasesExample;
  List<ParentPhrasesWithAll>? parentPhrasesWithAll;

  PhrasesWithAll(this.phrases, this.phrasesTranslate, this.phrasesExample, this.parentPhrasesWithAll);
}

class ParentPhrasesWithAll {
  ParentPhrasesModel? parentPhrases;
  List<ParentPhrasesExampleModel>? phrasesExample;
  List<ParentPhrasesTranslateModel>? parentPhrasesTranslate;

  ParentPhrasesWithAll(this.parentPhrases, this.phrasesExample, this.parentPhrasesTranslate);
}

class ParentsWithAll {
  ParentsWithAll(this.parents, this.wordsUz, this.collocation, this.culture, this.difference, this.grammar,
      this.metaphor, this.thesaurus, this.phrasesWithAll);

  ParentsModel? parents;
  List<WordsUzModel>? wordsUz;
  List<CollocationModel>? collocation;
  List<CultureModel>? culture;
  List<DifferenceModel>? difference;
  List<GrammarModel>? grammar;
  List<MetaphorModel>? metaphor;
  List<ThesaurusModel>? thesaurus;
  List<PhrasesWithAll>? phrasesWithAll;
}

class WordWithAll {
  WordModel? word;
  List<WordsUzModel>? wordsUz;
  List<CollocationModel>? collocation;
  List<CultureModel>? culture;
  List<DifferenceModel>? difference;
  List<GrammarModel>? grammar;
  List<MetaphorModel>? metaphor;
  List<ThesaurusModel>? thesaurus;
  List<PhrasesWithAll>? phrasesWithAll;
  List<ParentsWithAll>? parentsWithAll;

  WordWithAll(
      {this.word,
      this.wordsUz,
      this.collocation,
      this.culture,
      this.difference,
      this.grammar,
      this.metaphor,
      this.thesaurus,
      this.phrasesWithAll,
      this.parentsWithAll});
}
