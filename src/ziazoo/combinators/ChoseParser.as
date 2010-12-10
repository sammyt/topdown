/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 20:46
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class ChoseParser extends AbstractParser
  {
    private var parsers:Array;

    public function ChoseParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parse(parserState:ParserState):IResult
    {
      for each(var parser:IParser in parsers)
      {
        var result:IResult = parser.parse(parserState);

        if(result is Success)
        {
          return result;
        }
      }
      return new Failure("No options succeeded");
    }
  }
}
