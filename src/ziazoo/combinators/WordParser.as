/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:41
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class WordParser extends AbstractParser
  {
    private var w:String;

    public function WordParser(w:String)
    {
      this.w = w;
    }

    override public function parse(parserState:ParserState):IResult
    {
      var chars:String = parserState.subStr(w.length);

      if(chars == w)
      {
        parserState.move(w.length);
        return new Success(w, chars);
      }
      return new Failure("Expected [" + w + "] received [" + chars + "]");
    }
  }
}
