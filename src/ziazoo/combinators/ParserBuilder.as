/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 05/12/2010
 * Time: 17:38
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  import avmplus.accessorXml;

  import flash.utils.Dictionary;

  public class ParserBuilder
  {
    private var futures:Dictionary;

    public function   ParserBuilder()
    {
      futures = new Dictionary();
    }

    public function range(start:String, end:String):RangeParser
    {
      return new RangeParser(start, end);
    }

    public function oneOrMore(parser:Object):OneOrMoreParser
    {
      return new OneOrMoreParser(toParser(parser));
    }

    public function future(name:String):FutureParser
    {
      return futures[name] = new FutureParser();
    }

    public function either(first:Object, second:Object):EitherParser
    {
      return new EitherParser(toParser(first), toParser(second));
    }

    public function sequence(...args):SequenceParser
    {
      var parsers:Array = [];
      for each(var p:Object in args)
      {
        parsers.push(whitespace(toParser(p)));
      }
      return new SequenceParser(parsers);
    }

    public function zeroOrMore(parser:Object):ZeroOrMoreParser
    {
      return new ZeroOrMoreParser(toParser(parser));
    }

    public function satisfyFuture(name:String, parser:IParser):IParser
    {
      return FutureParser(futures[name]).parser = parser;
    }

    public function terminal(chars:String):WordParser
    {
      return new WordParser(chars);
    }

    private function toParser(obj:Object):IParser
    {
      if (obj is String)
      {
        return terminal(String(obj));
      }
      return obj as IParser;
    }

    public function chose(...args):ChoseParser
    {
      var parsers:Array = [];
      for each(var p:Object in args)
      {
        parsers.push(toParser(p));
      }
      return new ChoseParser(parsers);
    }

    public function re(regex:RegExp):RegExParser
    {
      return new RegExParser(new RegExp(regex));
    }

    public function repSep(parser:Object, seperator:Object):RepSepParser
    {
      return new RepSepParser(toParser(whitespace(parser)), toParser(whitespace(seperator)));
    }

    public function whitespace(parser:Object):WhitespaceParser
    {
      return new WhitespaceParser(toParser(parser));
    }
  }
}
