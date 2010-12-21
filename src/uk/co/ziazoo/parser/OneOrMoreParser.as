/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class OneOrMoreParser extends AbstractParser implements IParseAction
  {
    private var parser:IParser;
    private var list:Array;

    public function OneOrMoreParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parseState(state:IParserState):Result
    {
      var p:IParser = getParser();

      var result:Result = p.parseState(state);
      var firstResult:Result = result;

      if (!firstResult.success)
      {
        return new Fault("First pass of OneOrMore failed");
      }

      while (result.success)
      {
        result = p.parseState(state);
      }

      return new Result(true, true, action());
    }

    private function getParser():IParser
    {
      if (hasParseAction)
      {
        return parser;
      }

      list = [];
      return new InstanceListParser(parser, list);
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
