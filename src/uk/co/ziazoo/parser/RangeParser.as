/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:58
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class RangeParser extends AbstractParser
  {
    private var start:String;
    private var end:String;

    public function RangeParser(start:String, end:String)
    {
      this.start = start;
      this.end = end;
    }

    override public function parseState(parserState:IParserState):Result
    {
      var ch:String = parserState.at(0);
      if (ch >= start && ch <= end)
      {
        parserState.incr();

        return new Result(true, ch);
      }
      // TODO: new Failure("Expected something between [" + start + " - " + end + "] but got" + ch);
      return new Result(false);
    }
  }
}
