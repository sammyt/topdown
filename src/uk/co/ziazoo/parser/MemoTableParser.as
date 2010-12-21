/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 15:36
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class MemoTableParser extends ProxyParser
  {

    public function MemoTableParser(parser:IParser)
    {
      super(parser)
    }

    override public function parseState(state:IParserState):Result
    {
      var memo:IMemoTable = state.memo;

      var index:int = state.index;
      var id:String = target.id;

      if (memo.hasResult(id, index))
      {
        return memo.getResult(id, index);
      }

      var result:Result = target.parseState(state);
      memo.saveResult(id, index, result);
      return result;
    }
  }
}
