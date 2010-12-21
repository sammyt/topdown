/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:20
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class ChoiceParser extends AbstractParser
  {
    private var parsers:Array;

    public function ChoiceParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parseState(state:IParserState):Result
    {
      for each(var parser:IParser in parsers)
      {
        var result:Result = parser.parseState(state);

        if (result.success)
        {
          return result;
        }
      }
      return new Fault("No choice succeeded")
    }
  }
}
