/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 20:46
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class ChoseParser extends AbstractParser
  {
    private var parsers:Array;

    public function ChoseParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parseState(parserState:IParserState):Result
    {
      for each(var parser:IParser in parsers)
      {
        var result:Result = parser.parseState(parserState);

        if (result.success)
        {
          return result
        }
      }
      // new Failure("No options succeeded")
      return new Result(false);
    }
  }
}
