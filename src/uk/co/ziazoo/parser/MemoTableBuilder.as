/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class MemoTableBuilder implements IParserBuilder
  {
    private var builder:IParserBuilder;
    private var idCount:int = 0;

    public function MemoTableBuilder(builder:IParserBuilder)
    {
      this.builder = builder;
    }

    public function range(start:String, end:String):IParser
    {
      return memorize(builder.range(start, end));
    }

    private function memorize(parser:IParser):IParser
    {
      parser.id = "ID " + parser + idCount++;
      return new MemoTableParser(parser);
    }

    public function oneOrMore(parser:Object):IParser
    {
      return memorize(builder.oneOrMore(parser));
    }

    public function future(name:String):IParser
    {
      return builder.future(name);
    }

    public function either(first:Object, second:Object):IParser
    {
      return memorize(builder.either(first, second));
    }

    public function sequence(... args):IParser
    {
      var fn:Function = builder.sequence;
      return memorize(fn.apply(this, args));
    }

    public function zeroOrMore(parser:Object):IParser
    {
      return memorize(builder.zeroOrMore(parser));
    }

    public function satisfyFuture(name:String, parser:IParser):IParser
    {
      return builder.satisfyFuture(name, parser);
    }

    public function terminal(chars:String):IParser
    {
      return memorize(builder.terminal(chars));
    }

    public function toParser(obj:Object):IParser
    {
      return memorize(builder.toParser(obj));
    }

    public function chose(... args):IParser
    {
      var fn:Function = builder.chose;
      return memorize(fn.apply(this, args));
    }

    public function re(regex:RegExp):IParser
    {
      return memorize(builder.re(regex));
    }

    public function repSep(parser:Object, seperator:Object):IParser
    {
      return memorize(builder.repSep(parser, seperator));
    }

    public function whitespace(parser:Object):IParser
    {
      return memorize(builder.whitespace(parser));
    }
  }
}
