/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 22:20
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class RepSepParser extends AbstractParser
  {
    private var separator:IParser;
    private var parser:IParser;

    public function RepSepParser(parser:IParser, seperator:IParser)
    {
      this.parser = parser;
      this.separator = seperator;
    }

    override public function parseState(state:IParserState):Result
    {
      var list:Array;

      var sepParser:IParser = separator;
      var repParser:IParser = parser;

      if (!hasParseAction)
      {
        list = [];
        sepParser = new InstanceListParser(separator, list);
        repParser = new InstanceListParser(parser, list);
      }

      var first:Result = repParser.parseState(state);

      if (!first.success)
      {
        return first;
      }

      var sep:Result = sepParser.parseState(state);
      var rep:Result = repParser.parseState(state);

      while (sep.success && rep.success)
      {
        sep = sepParser.parseState(state);
        rep = repParser.parseState(state);
      }

      if (sep.success && !rep.success)
      {
        return new Fault("Separator without value");
      }

      if (hasParseAction)
      {
        return new Result(true, true, action());
      }
      return new Result(true, true, list.length == 1 ? list[0] : list);
    }
  }
}
