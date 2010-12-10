/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class SequenceParser extends AbstractParser
  {
    private var parsers:Array;

    public function SequenceParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parse(parserState:ParserState):IResult
    {
      var startIndex:int = parserState.index;
      var all:Array = [];

      for each(var parser:IParser in parsers)
      {
        var result:IResult = parser.parse(parserState);
        if (result is Success)
        {
          all.push(result);
        }
        else
        {
          return result;
        }
      }
      return new Success(all, parserState.subStrFrom(startIndex, parserState.index));
    }
  }
}
