import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisdom/core/utils/word_mapper.dart';
import 'package:wisdom/data/model/collocation_model.dart';
import 'package:wisdom/data/model/culture_model.dart';
import 'package:wisdom/data/model/difference_model.dart';
import 'package:wisdom/data/model/grammar_model.dart';
import 'package:wisdom/data/model/metaphor_model.dart';
import 'package:wisdom/data/model/parent_phrases_example_model.dart';
import 'package:wisdom/data/model/parent_phrases_model.dart';
import 'package:wisdom/data/model/parent_phrases_translate_model.dart';
import 'package:wisdom/data/model/parents_model.dart';
import 'package:wisdom/data/model/phrases_example_model.dart';
import 'package:wisdom/data/model/phrases_model.dart';
import 'package:wisdom/data/model/phrases_translate_model.dart';
import 'package:wisdom/data/model/thesaurus_model.dart';
import 'package:wisdom/data/model/word_and_parents_and_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_parents_and_phrases_parent_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_words_uz_model.dart';
import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_with_collocation_model.dart';
import 'package:wisdom/data/model/word_with_culture_model.dart';
import 'package:wisdom/data/model/word_with_difference_model.dart';
import 'package:wisdom/data/model/word_with_grammar_model.dart';
import 'package:wisdom/data/model/word_with_metaphor_model.dart';
import 'package:wisdom/data/model/word_and_phrases_model.dart';
import 'package:wisdom/data/model/word_with_theasurus_model.dart';
import 'package:wisdom/data/model/words_and_parents_and_words_uz_model.dart';
import 'package:wisdom/data/model/words_uz_model.dart';
import '../../data/model/catalog_model.dart';
import '../../data/model/phrases_with_all.dart';
import '../../data/model/word_and_parents_and_phrases_model.dart';
import '../../data/model/word_bank_model.dart';
import '../../data/model/word_model.dart';
import '../../data/model/word_with_difference_new_model.dart';

class DBHelper {
  DBHelper(this.wordMapper);

  final WordMapper wordMapper;
  late Database database;

  final String databaseName = 'waio_dictionary.db';
  final int databaseVersion = 1;
  final String tableWordEntity = 'word_entity';
  final String tableWordBank = 'word_bank';

  // opens the database (and creates if it do not exist)
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", databaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    database = await openDatabase(
      path,
      readOnly: false,
    );
  }

  Future saveAllWords(List<WordEntityModel> wordEntityModel) async {
    await saveWordToDB(wordMapper.wordEntityToWordList(wordEntityModel));
  }

  Future<void> saveWordToDB(List<WordModel> wordModel) async {
    try {
      if (database.isOpen) {
        for (var element in wordModel) {
          var id =
              await database.update(tableWordEntity, element.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
          log("updated Id: $id ");
        }
      }
    } catch (e) {
      log("saveWordToDB", error: e.toString());
    }
  }

  Future<WordWithGrammarModel?> getGrammar() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,g.id as g_id FROM word_entity we INNER JOIN grammar g ON we.id=g.word_id order by random() limit 1");
        var model = WordWithGrammarModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getGrammar", error: e.toString());
    }
    return null;
  }

  Future<WordWithDifferenceNewModel?> getDifference() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,d.id as d_id,d.word as d_word FROM word_entity we INNER JOIN difference d ON we.id=d.word_id WHERE d.word LIKE '%or%' ORDER BY random() limit 1");
        var model = WordWithDifferenceNewModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getDifference", error: e.toString());
    }
    return null;
  }

  Future<WordWithTheasurusModel?> getThesaurus() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,t.id as t_id,t.body as t_body FROM word_entity we INNER JOIN thesaurus t ON we.id=t.word_id order by random() limit 1");
        var model = WordWithTheasurusModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getThesaurus", error: e.toString());
    }
    return null;
  }

  Future<WordWithCollocationModel?> getCollocation() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,c.id as c_id FROM word_entity we INNER JOIN collocation c ON we.id=c.word_id order by random() limit 1");
        var model = WordWithCollocationModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getCollocation", error: e.toString());
    }
    return null;
  }

  Future<WordWithMetaphorModel?> getMetaphor() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,m.id as m_id FROM word_entity we INNER JOIN metaphor m ON we.id=m.word_id order by random() limit 1");
        var model = WordWithMetaphorModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getMetaphor", error: e.toString());
    }
    return null;
  }

  Future<WordModel?> getImage() async {
    try {
      if (database.isOpen) {
        var response =
            await database.rawQuery("select * from word_entity where image!='null' order by random() limit 1");
        var model = WordModel.fromJson(response.first);
        return model;
      }
    } catch (e) {
      log("getImage", error: e.toString());
    }
    return null;
  }

  Future<WordModel?> getWord() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery("select * from word_entity where word !='[]' order by random() limit 1");
        var wordModel = WordModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getWord", error: e.toString());
    }
    return null;
  }

  Future<WordWithGrammarModel?> getTimeLineGrammar1(String grammarId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,g.id as g_id,g.body as g_body FROM word_entity we INNER JOIN grammar g ON we.id=g.word_id WHERE g.id=$grammarId");
        var wordModel = WordWithGrammarModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineGrammar1", error: e.toString());
    }
    return null;
  }

  Future<WordWithTheasurusModel?> getTimeLineThesaurus(String thesaurusId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,t.id as t_id,t.body as t_body FROM word_entity we INNER JOIN thesaurus t ON we.id=t.word_id WHERE t.id=$thesaurusId ");
        var wordModel = WordWithTheasurusModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineThesaurus", error: e.toString());
    }
    return null;
  }

  Future<WordWithCollocationModel?> getTimeLineCollocation(String collocationId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,c.id as c_id,c.body as c_body FROM word_entity we INNER JOIN collocation c ON we.id=c.word_id WHERE c.id=$collocationId");
        var wordModel = WordWithCollocationModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineCollocation", error: e.toString());
    }
    return null;
  }

  Future<WordWithMetaphorModel?> getTimeLineMetaphor(String metaphorId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,m.id as m_id,m.body as m_body FROM word_entity we INNER JOIN metaphor m ON we.id=m.word_id WHERE m.id= $metaphorId");
        var wordModel = WordWithMetaphorModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineMetaphor", error: e.toString());
    }
    return null;
  }

  Future<WordWithCultureModel?> getTimeLineCulture(String cultureId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT we.id,we.word,c.id as c_id,c.body as c_body FROM word_entity we INNER JOIN culture c ON we.id=c.word_id WHERE c.id=$cultureId");
        var wordModel = WordWithCultureModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineCulture", error: e.toString());
    }
    return null;
  }

  Future<WordWithDifferenceModel?> getTimeLineDifference(String differenceId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT d.id as d_id,d.word as d_word,d.body as d_body FROM difference d WHERE d.id=$differenceId");
        var wordModel = WordWithDifferenceModel.fromJson(response.first);
        return wordModel;
      }
    } catch (e) {
      log("getTimeLineDifference", error: e.toString());
    }
    return null;
  }

  Future<CatalogModel?> getSpeaking() async {
    try {
      if (database.isOpen) {
        var response =
            await database.rawQuery("SELECT id,word FROM catalogue WHERE word!='' ORDER BY random() LIMIT 1");
        var model = CatalogModel.fromJson(response.last);
        return model;
      }
    } catch (e) {
      log("getSpeaking", error: e.toString());
    }
    return null;
  }

  Future<List<CatalogModel>?> getCatalogsList(String catalogId) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery("SELECT * FROM catalogue WHERE category= '$catalogId' ");
        var model = List<CatalogModel>.from(response.map((e) => CatalogModel.fromJson(e)));
        return model;
      }
    } catch (e) {
      log("getCatalogsList", error: e.toString());
    }
    return null;
  }

  Future<List<CatalogModel>?> getTitleList(String categoryId, String? title) async {
    try {
      var newTitle = title != null ? "AND title LIKE '$title%'" : "";
      if (database.isOpen) {
        var response = await database.rawQuery("SELECT * FROM catalogue WHERE category='$categoryId' $newTitle");
        var model = List<CatalogModel>.from(response.map((e) => CatalogModel.fromJson(e)));
        return model;
      }
    } catch (e) {
      log("getTitleList", error: e.toString());
    }
    return null;
  }

  Future<List<CatalogModel>?> getIfWordIsWordenList(String categoryId, String query) async {
    try {
      if (database.isOpen) {
        var response = await database
            .rawQuery("SELECT * FROM catalogue WHERE category= '$categoryId' AND wordenword LIKE '${query.replaceAll("'", "''")}%'");
        var model = List<CatalogModel>.from(response.map((e) => CatalogModel.fromJson(e)));
        return model;
      }
    } catch (e) {
      log("getIfWordIsWordenList", error: e.toString());
    }
    return null;
  }

  Future<List<CatalogModel>?> getCatalogWordList(String categoryId, String query) async {
    try {
      if (database.isOpen) {
        var response =
            await database.rawQuery("SELECT * FROM catalogue WHERE category= '$categoryId' AND word LIKE '${query.replaceAll("'", "''")}%'");
        var model = List<CatalogModel>.from(response.map((e) => CatalogModel.fromJson(e)));
        return model;
      }
    } catch (e) {
      log("getCatalogWordList", error: e.toString());
    }
    return null;
  }

  Future<WordWithAll?> getWord1(int? id) async {
    try {
      WordWithAll _word;
      if (database.isOpen) {
        var responseAll = await database.rawQuery("SELECT * FROM word_entity WHERE id=$id LIMIT 1");
        var word = responseAll.isNotEmpty ? WordModel.fromJson(responseAll.first) : null;

        var responseWordUz = await database.rawQuery("SELECT * FROM words_uz WHERE word_id=$id");
        var wordWordUz = responseWordUz.isNotEmpty
            ? List<WordsUzModel>.from(responseWordUz.map((e) => WordsUzModel.fromJson(e)))
            : null;

        var responseCollocation = await database.rawQuery("SELECT * FROM collocation WHERE word_id=$id ");
        var wordCollocation = responseCollocation.isNotEmpty
            ? List<CollocationModel>.from(responseCollocation.map((e) => CollocationModel.fromJson(e)))
            : null;

        var responseCulture = await database.rawQuery("SELECT * FROM culture WHERE word_id=$id ");
        var wordCulture = responseCulture.isNotEmpty
            ? List<CultureModel>.from(responseCulture.map((e) => CultureModel.fromJson(e)))
            : null;

        var responseDifference = await database.rawQuery("SELECT * FROM difference WHERE word_id=$id ");
        var wordDifference = responseDifference.isNotEmpty
            ? List<DifferenceModel>.from(responseDifference.map((e) => DifferenceModel.fromJson(e)))
            : null;

        var responseGrammar = await database.rawQuery("SELECT * FROM grammar WHERE word_id=$id ");
        var wordGrammar = responseGrammar.isNotEmpty
            ? List<GrammarModel>.from(responseGrammar.map((e) => GrammarModel.fromJson(e)))
            : null;

        var responseMetaphor = await database.rawQuery("SELECT * FROM metaphor WHERE word_id=$id ");
        var wordMetaphor = responseMetaphor.isNotEmpty
            ? List<MetaphorModel>.from(responseMetaphor.map((e) => MetaphorModel.fromJson(e)))
            : null;

        var responseThesaurus = await database.rawQuery("SELECT * FROM thesaurus WHERE word_id=$id ");
        var wordThesaurus = responseThesaurus.isNotEmpty
            ? List<ThesaurusModel>.from(responseThesaurus.map((e) => ThesaurusModel.fromJson(e)))
            : null;

        var phrasesWithAll = await getPhrasesAll(id);

        var parentWithAll = await getParentsWithAll(id);

        _word = WordWithAll(
            word: word,
            phrasesWithAll: phrasesWithAll,
            thesaurus: wordThesaurus,
            metaphor: wordMetaphor,
            grammar: wordGrammar,
            difference: wordDifference,
            culture: wordCulture,
            collocation: wordCollocation,
            wordsUz: wordWordUz,
            parentsWithAll: parentWithAll);

        return _word;
      }
    } catch (e) {
      log("getSpeaking", error: e.toString());
    }
    return null;
  }

  Future<List<PhrasesWithAll>> getPhrasesAll(int? id) async {
    List<PhrasesWithAll> phrasesWithAll = [];

    var responsePhrases = await database.rawQuery("SELECT * FROM phrases WHERE p_word_id=$id ");
    var phrases =
        responsePhrases.isNotEmpty ? List<PhrasesModel>.from(responsePhrases.map((e) => PhrasesModel.fromJson(e))) : [];

    for (var element in phrases) {
      var responsePhrasesTranslate =
          await database.rawQuery("SELECT * FROM phrases_translate WHERE phrase_id=${element.pId} ");
      var wordPhraseTranslate = responsePhrasesTranslate.isNotEmpty
          ? List<PhrasesTranslateModel>.from(responsePhrasesTranslate.map((e) => PhrasesTranslateModel.fromJson(e)))
          : null;

      var responsePhrasesExample =
          await database.rawQuery("SELECT * FROM phrases_example WHERE phrase_id=${element.pId} ");
      var wordPhraseExample = responsePhrasesExample.isNotEmpty
          ? List<PhrasesExampleModel>.from(responsePhrasesExample.map((e) => PhrasesExampleModel.fromJson(e)))
          : null;

      var parentsPhrasesWithAll = await getParentPhrasesWithAll(element.pId);

      phrasesWithAll.add(PhrasesWithAll(element, wordPhraseTranslate, wordPhraseExample, parentsPhrasesWithAll));
    }
    return phrasesWithAll;
  }

  Future<List<ParentPhrasesWithAll>> getParentPhrasesWithAll(int? pId) async {
    List<ParentPhrasesWithAll>? _parentPhrasesWithAll = [];

    var responseParentPhrases = await database.rawQuery("SELECT * FROM parent_phrases WHERE phrase_id=$pId");
    var parentPhrases = responseParentPhrases.isNotEmpty
        ? List<ParentPhrasesModel>.from(responseParentPhrases.map((e) => ParentPhrasesModel.fromJson(e)))
        : [];

    for (var element in parentPhrases) {
      var responseParentPhrasesExample =
          await database.rawQuery("SELECT * FROM parent_phrases_example WHERE phrase_id=${element.id}");
      var wordPhraseParentPhrasesExample = responseParentPhrasesExample.isNotEmpty
          ? List<ParentPhrasesExampleModel>.from(
              responseParentPhrasesExample.map((e) => ParentPhrasesExampleModel.fromJson(e)))
          : null;

      var responseParentPhrasesTranslate =
          await database.rawQuery("SELECT * FROM parent_phrases_translate WHERE phrase_id=${element.id}");
      var wordPhraseParentPhrasesTranslate = responseParentPhrasesTranslate.isNotEmpty
          ? List<ParentPhrasesTranslateModel>.from(
              responseParentPhrasesTranslate.map((e) => ParentPhrasesTranslateModel.fromJson(e)))
          : null;
      if ((element.word != null && element.word!.isNotEmpty) ||
          (element.wordClassComment != null && element.wordClassComment.isNotEmpty)) {
        _parentPhrasesWithAll
            .add(ParentPhrasesWithAll(element, wordPhraseParentPhrasesExample, wordPhraseParentPhrasesTranslate));
      }
    }
    return _parentPhrasesWithAll;
  }

  Future<List<ParentsWithAll>?> getParentsWithAll(int? id) async {
    List<ParentsWithAll> _parentsWithAll = [];

    var responseParents = await database.rawQuery("SELECT * FROM parents WHERE word_id=$id");
    var parents =
        responseParents.isNotEmpty ? List<ParentsModel>.from(responseParents.map((e) => ParentsModel.fromJson(e))) : [];

    for (var value in parents) {
      var responseWordUz = await database.rawQuery("SELECT * FROM words_uz WHERE word_id=${value.id} ");
      var wordWordUz = responseWordUz.isNotEmpty
          ? List<WordsUzModel>.from(responseWordUz.map((e) => WordsUzModel.fromJson(e)))
          : null;

      var responseCollocation = await database.rawQuery("SELECT * FROM collocation WHERE word_id=${value.id} ");
      var wordCollocation = responseCollocation.isNotEmpty
          ? List<CollocationModel>.from(responseCollocation.map((e) => CollocationModel.fromJson(e)))
          : null;

      var responseCulture = await database.rawQuery("SELECT * FROM culture WHERE word_id=${value.id}");
      var wordCulture = responseCulture.isNotEmpty
          ? List<CultureModel>.from(responseCulture.map((e) => CultureModel.fromJson(e)))
          : null;

      var responseDifference = await database.rawQuery("SELECT * FROM difference WHERE word_id=${value.id} ");
      var wordDifference = responseDifference.isNotEmpty
          ? List<DifferenceModel>.from(responseDifference.map((e) => DifferenceModel.fromJson(e)))
          : null;

      var responseGrammar = await database.rawQuery("SELECT * FROM grammar WHERE word_id=${value.id} ");
      var wordGrammar = responseGrammar.isNotEmpty
          ? List<GrammarModel>.from(responseGrammar.map((e) => GrammarModel.fromJson(e)))
          : null;

      var responseMetaphor = await database.rawQuery("SELECT * FROM metaphor WHERE word_id=${value.id} ");
      var wordMetaphor = responseMetaphor.isNotEmpty
          ? List<MetaphorModel>.from(responseMetaphor.map((e) => MetaphorModel.fromJson(e)))
          : null;

      var responseThesaurus = await database.rawQuery("SELECT * FROM thesaurus WHERE word_id=${value.id} ");
      var wordThesaurus = responseThesaurus.isNotEmpty
          ? List<ThesaurusModel>.from(responseThesaurus.map((e) => ThesaurusModel.fromJson(e)))
          : null;

      var phrasesWithAll = await getPhrasesAll(value.id);

      _parentsWithAll.add(
        ParentsWithAll(value, wordWordUz, wordCollocation, wordCulture, wordDifference, wordGrammar, wordMetaphor,
            wordThesaurus, phrasesWithAll),
      );
    }

    return _parentsWithAll;
  }

  Future<List<WordModel>?> searchByWord(String word) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT id,word,word_classid,word_classword_id,word_classword_class FROM word_entity WHERE word LIKE '${word.replaceAll("'", "''")}%' ORDER BY word COLLATE NOCASE ASC LIMIT 40");
        var words = List<WordModel>.from(response.map((e) => WordModel.fromJson(e)));
        return words;
      }
    } catch (e) {
      log("searchByWord", error: e.toString());
    }
    return null;
  }

  Future<List<WordAndPhrasesModel>?> searchByPhrases(String search) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT id,word_classid,word_classword_id,word_classword_class,p_word FROM word_entity INNER JOIN phrases ON id=p_word_id AND p_word LIKE '${search.replaceAll("'", "''")}%' ORDER BY word COLLATE NOCASE asc limit 40");
        var wordWithPhrases = List<WordAndPhrasesModel>.from(response.map((e) => WordAndPhrasesModel.fromJson(e)));
        return wordWithPhrases;
      }
    } catch (e) {
      log("searchByPhrases", error: e.toString());
    }
    return null;
  }

  Future<List<WordAndParentsAndPhrasesModel>?> searchByWordParent1(String parents) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,w.word_classid,w.word_classword_id,w.word_classword_class,ph.p_word FROM word_entity w INNER JOIN parents p ON w.id=p.word_id INNER JOIN phrases ph ON p.id=ph.p_word_id AND ph.p_word LIKE '${parents.replaceAll("'", "''")}%' order by  w.word COLLATE NOCASE asc  limit 40");
        var wordsAndParentsAndWordsUzModel =
            List<WordAndParentsAndPhrasesModel>.from(response.map((e) => WordAndParentsAndPhrasesModel.fromJson(e)));
        return wordsAndParentsAndWordsUzModel;
      }
    } catch (e) {
      log("searchByWordParent1", error: e.toString());
    }
    return null;
  }

  Future<List<WordsAndParentsAndWordsUzModel>?> searchByWordParent2(String parents) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,w.word as word_class,p.star,wu.word as word FROM word_entity w INNER JOIN parents p ON w.id=p.word_id INNER JOIN words_uz wu ON p.id=wu.word_id AND wu.word LIKE '${parents.replaceAll("'", "''")}%' order by w.word COLLATE NOCASE asc limit 40");
        var wordsAndParentsAndWordsUzModel =
            List<WordsAndParentsAndWordsUzModel>.from(response.map((e) => WordsAndParentsAndWordsUzModel.fromJson(e)));
        return wordsAndParentsAndWordsUzModel;
      }
    } catch (e) {
      log("searchByWordParent2", error: e.toString());
    }
    return null;
  }

  Future<List<WordAndParentsAndPhrasesAndTranslateModel>?> searchByWordParent3(String parents) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,ph.p_word as word_class,ph.p_star,pt.word as word FROM word_entity w INNER JOIN parents p ON w.id=p.word_id INNER JOIN phrases ph ON p.id=ph.p_word_id INNER JOIN phrases_translate pt ON ph.p_id=pt.phrase_id AND pt.word LIKE '${parents.replaceAll("'", "''")}%' order by w.word COLLATE NOCASE asc limit 40");
        var wordsAndParentsAndWordsUzModel = List<WordAndParentsAndPhrasesAndTranslateModel>.from(
            response.map((e) => WordAndParentsAndPhrasesAndTranslateModel.fromJson(e)));
        return wordsAndParentsAndWordsUzModel;
      }
    } catch (e) {
      log("searchByWordParent3", error: e.toString());
    }
    return null;
  }

  Future<List<WordAndParentsAndPhrasesParentPhrasesAndTranslateModel>?>
      searchWordAndParentsAndPhrasesParentPhrasesAndTranslate(String parents) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,w.word as word_class,p_ph.star,ppt.word as word FROM word_entity w INNER JOIN parents p ON w.id=p.word_id INNER JOIN phrases ph ON p.id=ph.p_word_id INNER JOIN parent_phrases p_ph ON ph.p_id=p_ph.phrase_id INNER JOIN parent_phrases_translate ppt ON p_ph.id=ppt.parent_phrase_id AND ppt.word LIKE '${parents.replaceAll("'", "''")}%' order by  w.word COLLATE NOCASE asc limit 40");
        var wordAndParentsAndPhrasesParentPhrasesAndTranslateModel =
            List<WordAndParentsAndPhrasesParentPhrasesAndTranslateModel>.from(
                response.map((e) => WordAndParentsAndPhrasesParentPhrasesAndTranslateModel.fromJson(e)));
        return wordAndParentsAndPhrasesParentPhrasesAndTranslateModel;
      }
    } catch (e) {
      log("searchWordAndParentsAndPhrasesParentPhrasesAndTranslate", error: e.toString());
    }
    return null;
  }

  Future<List<WordAndWordsUzModel>?> searchByWordUz1(String word) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,w.word as word_class,w.star,wu.word as word FROM word_entity w INNER JOIN words_uz wu ON w.id=wu.word_id and wu.word LIKE '${word.replaceAll("'", "''")}%' ORDER BY wu.word COLLATE NOCASE asc,star desc LIMIT 40");
        var wordAndWordsUzModel = List<WordAndWordsUzModel>.from(response.map((e) => WordAndWordsUzModel.fromJson(e)));
        return wordAndWordsUzModel;
      }
    } catch (e) {
      log("searchByWordUz1", error: e.toString());
    }
    return null;
  }

  Future<List<String>> wordsUz(int id) async {
    var responseWordUz = await database.rawQuery("SELECT word FROM words_uz WHERE word_id=$id");
    var wordWordUz = responseWordUz.isNotEmpty
        ? List<String>.from(responseWordUz.map((e) => WordsUzModel.fromJson(e).word ?? ""))
        : [] as List<String>;
    return wordWordUz;
  }

  Future<List<WordAndPhrasesAndTranslateModel>?> searchByPhrasesUz1(String phrases) async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery(
            "SELECT w.id,w.word as word_class,p.p_star,pt.word as word FROM word_entity w INNER JOIN phrases p ON w.id=p.p_word_id INNER JOIN phrases_translate pt ON p.p_id=pt.phrase_id AND p.p_word LIKE '${phrases.replaceAll("'", "''")}%' order by w.word COLLATE NOCASE asc,w.star desc limit 40");
        var wordAndPhrasesAndTranslateModel = List<WordAndPhrasesAndTranslateModel>.from(
            response.map((e) => WordAndPhrasesAndTranslateModel.fromJson(e)));
        return wordAndPhrasesAndTranslateModel;
      }
    } catch (e) {
      log("searchByPhrasesUz1", error: e.toString());
    }
    return null;
  }

  Future<List<WordBankModel>?> getWordBankList() async {
    try {
      if (database.isOpen) {
        var response = await database.rawQuery("SELECT * from word_bank ORDER BY created_at DESC");
        var wordBankList = List<WordBankModel>.from(response.map((e) => WordBankModel.fromJson(e)));
        return wordBankList;
      }
    } catch (e) {
      log("getWordBankList", error: e.toString());
    }
    return null;
  }

  Future<void> saveToWordBank(WordBankModel wordBankModel) async {
    try {
      if (database.isOpen) {
        await database.insert(tableWordBank, wordBankModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      log("saveToWordBank", error: e.toString());
    }
  }

  Future<void> deleteAllWordBank() async {
    try {
      if (database.isOpen) {
        await database.delete(tableWordBank);
      }
    } catch (e) {
      log("deleteAllWordBank", error: e.toString());
    }
  }

  Future<void> deleteWordBank(WordBankModel model) async {
    try {
      if (database.isOpen) {
        await database.delete(tableWordBank, where: "id = ?", whereArgs: [model.id]);
      }
    } catch (e) {
      log("deleteWordBank", error: e.toString());
    }
  }

  Future<void> updateWordBank(WordBankModel model) async {
    try {
      if (database.isOpen) {
        await database.update(tableWordBank, model.toJson(),
            where: "id = ?", whereArgs: [model.id], conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      log("updateWordBank", error: e.toString());
    }
  }
}
