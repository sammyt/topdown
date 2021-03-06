/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:41
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class WordParser extends AbstractParser
  {
    private var w:String;

    public function WordParser(w:String)
    {
      this.w = w;
    }

    override public function parseState(state:IParserState):Result
    {
      var chars:String = state.subStr(w.length);

      if (chars == w)
      {
        state.move(w.length);
        return new Result(true, true, w);
      }
      return new Fault("Expected [" + w + "] received [" + chars + "]");
    }
  }
}
