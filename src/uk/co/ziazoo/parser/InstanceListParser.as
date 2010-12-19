/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 15:33
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class InstanceListParser extends ProxyParser
  {
    private var list:Array;

    public function InstanceListParser(target:IParser, list:Array)
    {
      super(target);

      this.list = list;
    }

    override public function parseState(state:IParserState):Result
    {
      var result:Result = target.parseState(state);

      if (result.success && result.producedOutput)
      {
        list.push(result.instance);
      }
      return result;
    }
  }
}
