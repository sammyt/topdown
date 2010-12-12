/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class SequenceParser extends AbstractParser
  {
    private var parsers:Array;

    public function SequenceParser(parsers:Array)
    {
      this.parsers = parsers;
    }

    override public function parse(parserState:ParserState):Result
    {
      var all:Array = [];

      for each(var parser:IParser in parsers)
      {
        var result:Result = parser.parse(parserState);
        if (result.success)
        {
          all.push(result.instance);
        }
        else
        {
          return new Result(false);
        }
      }
      if (all.length == 0)
      {
        return new Result(false);
      }
      if (all.length == 1)
      {
        return new Result(true, apply(all[0]));
      }
      return new Result(true, apply(all));
    }
  }
}
