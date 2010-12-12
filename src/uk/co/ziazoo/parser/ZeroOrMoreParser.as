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

    override public function parse(parserState:ParserState):Result
    {
      var all:Array;
      var result:Result = parser.parse(parserState);

      while (result.success)
      {
        if (!all) all = [];

        all.push(result.instance);
        result = parser.parse(parserState);
      }

      if (all && all.length == 1)
      {
        return new Result(true, apply(all[0]));
      }
      return new Result(true, apply(all));
    }
  }
}
