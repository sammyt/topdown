/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class ZeroOrMoreParser extends AbstractParser
  {
    private var parser:IParser;

    public function ZeroOrMoreParser(parser:IParser)
    {
      this.parser = parser;
    }

    override public function parseState(state:IParserState):Result
    {
      var p:IParser = parser;

      if (!hasParseAction)
      {
        var list:Array = [];
        p = new InstanceListParser(parser, list);
      }

      var result:Result = p.parseState(state);
      var firstResult:Result = result;

      while (result.success)
      {
        result = p.parseState(state);
      }

      if (firstResult.success && firstResult.producedOutput)
      {
        if (hasParseAction)
        {
          return new Result(true, true, action());
        }
        return new Result(true, true, list.length == 1 ? list[0] : list);
      }
      return new Result(true, false);
    }
  }
}
