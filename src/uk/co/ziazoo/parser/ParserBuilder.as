/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 05/12/2010
 * Time: 17:38
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  public class ParserBuilder implements IParserBuilder
  {
    private var futures:Dictionary;

    public function ParserBuilder()
    {
      futures = new Dictionary();
    }

    public function range(start:String, end:String):IParser
    {
      return new RangeParser(start, end);
    }

    public function oneOrMore(parser:Object):IParser
    {
      return new OneOrMoreParser(toParser(parser));
    }

    public function future(name:String):IParser
    {
      futures[name] = new FutureParser();
      return futures[name];
    }

    public function either(first:Object, second:Object):IParser
    {
      return new EitherParser(toParser(first), toParser(second));
    }

    public function sequence(...args):IParser
    {
      var parsers:Array = [];
      for each(var p:Object in args)
      {
        parsers.push(whitespace(toParser(p)));
      }
      return new SequenceParser(parsers);
    }

    public function zeroOrMore(parser:Object):IParser
    {
      return new ZeroOrMoreParser(toParser(parser));
    }

    public function satisfyFuture(name:String, parser:IParser):IParser
    {
      var f:FutureParser = futures[name] as FutureParser;
      f.target = parser;
      return f;
    }

    public function terminal(chars:String):IParser
    {
      return new WordParser(chars);
    }

    public function toParser(obj:Object):IParser
    {
      if (obj is String)
      {
        return terminal(String(obj));
      }
      return obj as IParser;
    }

    public function chose(...args):IParser
    {
      var parsers:Array = [];
      for each(var p:Object in args)
      {
        parsers.push(toParser(p));
      }
      return new ChoseParser(parsers);
    }

    public function re(regex:RegExp):IParser
    {
      return new RegExParser(new RegExp(regex));
    }

    public function repSep(parser:Object, seperator:Object):IParser
    {
      return new RepSepParser(whitespace(parser), whitespace(seperator));
    }

    public function whitespace(parser:Object):IParser
    {
      return new WhitespaceParser(toParser(parser));
    }
  }
}
