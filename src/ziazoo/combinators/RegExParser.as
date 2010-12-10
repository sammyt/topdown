/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 20:53
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class RegExParser extends AbstractParser
  {
    private var re:RegExp;
    
    public function RegExParser(re:RegExp)
    {
      this.re = re;
    }

    override public function parse(parserState:ParserState):IResult
    {
      var input:String = re.exec(parserState.subStr(parserState.len));

      var ans:Array = re.exec(parserState.subStr(parserState.len));
      if(ans && ans.length)
      {
        parserState.move(ans[0].length);
        return new Success(ans[0], input);
      }
      return new Failure("Pattern not found");
    }
  }
}
