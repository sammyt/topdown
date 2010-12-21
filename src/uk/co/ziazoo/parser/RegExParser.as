/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 20:53
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class RegExParser extends AbstractParser
  {
    private var re:RegExp;

    public function RegExParser(re:RegExp)
    {
      this.re = re;
    }

    override public function parseState(state:IParserState):Result
    {
      var ans:Array = re.exec(state.subStr(state.len));

      if (ans && ans.length)
      {
        state.move(ans[0].length);
        return new Result(true, true, ans[0]);
      }
      return new Fault("Pattern not found " + re.source);
    }
  }
}
