/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class OneOrMoreParser extends AbstractParser
  {
    private var parser:IParser;

    public function OneOrMoreParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parseState(state:IParserState):Result
    {
      var p:IParser = parser;
      var list:Array;

      if (!hasParseAction)
      {
        list = [];
        p = new InstanceListParser(parser, list);
      }

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

      if (hasParseAction)
      {
        return new Result(true, true, action());
      }
      return new Result(true, true, list.length == 1 ? list[0] : list);
    }

  }
}
