/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 22:20
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class RepSepParser extends AbstractParser implements IParseAction
  {
    private var separator:IParser;
    private var parser:IParser;
    private var list:Array;

    public function RepSepParser(parser:IParser, seperator:IParser)
    {
      this.parser = parser;
      this.separator = seperator;
    }

    override public function parseState(state:IParserState):Result
    {
      var sepParser:IParser = getSepParser();
      var repParser:IParser = getRepParser();

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
      return new Result(true, true, action());
    }

    private function getRepParser():IParser
    {
      if (hasParseAction)
      {
        return parser;
      }
      return new InstanceListParser(parser, list);
    }

    private function getSepParser():IParser
    {
      if (hasParseAction)
      {
        return separator;
      }

      list = [];
      return new InstanceListParser(separator, list);
    }

    public function extract():Object
    {
      var tmp:Array = list;
      list = [];
      return tmp;
    }

    override protected function get parseAction():IParseAction
    {
      return super.parseAction || this;
    }
  }
}
