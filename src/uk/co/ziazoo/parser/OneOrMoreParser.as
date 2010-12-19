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

    override public function parseState(parserState:IParserState):Result
    {
      var all:Array = [];

      var result:Result = parser.parseState(parserState);

      if (!result.success)
      {
        // TODO: call fail object
        return new Result(false);
      }

      while (result.success)
      {
        all.push(result.instance);
        result = parser.parseState(parserState);
      }

      if (all.length == 1)
      {
        // return new Result(true, apply(all[0]));
      }

      // return new Result(true, apply(all));
      return null;
    }
  }
}
